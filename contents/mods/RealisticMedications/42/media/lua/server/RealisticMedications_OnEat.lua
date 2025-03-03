--- This is the file that will be used to handle the consumption of the Codeine Pills and the side effects for now.
--- This will be expanded upon in the future to include other medications and their effects.



--- @type Item_OnEat
function CodeineConsumptionFunc(item, character, amount)
    local player = character -- Use the character that ate the pills 
    local mdata = player:getModData() -- Get the mod data for the player
    local player_stats = player:getStats() -- Get the Players Statistics to enable them to be manipulated later
    local player_bd = player:getBodyDamage() -- Get the players body damage to enable them to be manipulated later
    local player_bh = player_bd:getOverallBodyHealth() -- Obtains the players overall body health to enable it to be manipulated later
    
    -- This "or 0" is required because initially, the variable will be nil (non-existent) so you
    -- have to set it to a default value. Basically "true or 0" will return true, and "false or 0" will return 0.
    mdata.CodeinePillsConsumed = (mdata.CodeinePillsConsumed or 0) + 1
   
    local pillsEaten = mdata.CodeinePillsConsumed -- set this once we've verified it cant be null and retrieved the value!

    -- Change this to else if, because otherwise it will always return true!
    -- Also, we have to reverse the if tree, because >= 1 will ALWAYS return true, even if they've eaten 1000000 and should theoretically die!!! If else will then skip the rest of the tree and go right to "end".
    -- So you could put >= 15 at the top adn then >= 1 at the bottom, but I prefer to invert the statement, so
    -- it is LESS THAN which works just as well.
    
    if pillsEaten <= 10 then
        player:Say("I feel a little better")
        player_bd:setPainReduction(1500)
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        print("Player Current Body health is "..player_bh )
    elseif pillsEaten <= 5 then
        player_bd:setFoodSicknessLevel(20)
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
    elseif pillsEaten > 5 and mdata.CodeinePillsConsumed < 8 then
        player:Say("I Feel Sick, I should Stop")
        player_bd:setFoodSicknessLevel(30)
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
    elseif pillsEaten <= 8 then
        print("player has consumed AT LEAST 8 pills")
        player:Say("My stomach is killing me...")
        player_bd:setFoodSicknessLevel(50)
        player_bd:getBodyPart(BodyPartType.Torso_Lower):SetHealth(50)
    elseif pillsEaten <= 12 then
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("I feel like I'm going to die")
        player_bd:setFoodSicknessLevel(75)
        player_bd:setPanicIncreaseValue(75)
        player_bd:setDiscomfortLevel(50)
        player_stats:setFatigue(100)
        player_stats:setPain(100)
        player_bd:getBodyPart(BodyPartType.Torso_Upper):SetHealth(45)
        player_bd:getBodyPart(BodyPartType.Torso_Lower):SetHealth(45)
    elseif pillsEaten <= 15 then
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("I can't stay awake...")
        player_bd:getBodyPart(BodyPartType.Torso_Upper):SetHealth(25)
        player_bd:getBodyPart(BodyPartType.Torso_Lower):SetHealth(45)

        --stages after this are considered the endgame stages
        --players are intentionally at the point of taking pills, and the messages are to try and emulate the characters mindset 
        --They are going to die if they continue to take the pills beyond this point if the continue their behaviour, we are trying to implore them to stop and think, alongside show the severity of their actions
        
    elseif pillsEaten <= 16 then
        player:Say("I'm sorry, I'm so sorry")
        player:Say("*Muffled Crying*") 
        
    elseif pillsEaten <= 17 then
        player:Say("I don't want to go alone...")
    
    elseif pillsEaten <=18 then 
        player:Say("Not long left now...")
        player:Say("*sniffling*")

    elseif pillsEaten <=19 then
        player:Say("Mom, Dad, I love you")
        player:Say("*Muffled Crying*")

    elseif pillsEaten >=20 then
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("*Gurgling Sounds*")
        player_bd:setOverallBodyHealth(0)

        --Final stage of the codeine overdose, the player dies. 

    elseif pillsEaten <=100 then
        player:Say("I have taken "..mdata.CodeinePillsConsumed.." pills")
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")

        -- Kill the player instantly at this point 
        -- Here means they've eaten far too many. More than 15 to be exact!
        
    end

    

end



function PillElimination()
    local player = getPlayer()
    local mdata = player:getModData()
    local timeofday = getGameTime():getTimeOfDay()
    
    if mdata.CodeinePillsConsumed and mdata.CodeinePillsConsumed > 0 then
        -- Have some effects here that get applied every minute the codeine is active
        mdata.CodieneDegradation = mdata.CodeinePillsConsumed -1
        mdata.CodeinePillsConsumed = mdata.CodieneDegradation
        print("Current Time is "..timeofday)
        print("Codeine Value has decreased to "..mdata.CodieneDegradation)
        if mdata.CodeinePillsConsumed <= 1 then
            player:Say("I think it's all out of my system")
        elseif mdata.CodeinePillsConsumed <=8 then
            player:Say("I feel a little better, I don't think I should overdo it like that in the future")
        elseif mdata.CodeinePillsConsumed <= 12 then
            player:Say("I think I might make it through this...")
        elseif mdata.CodeinePillsConsumed <= 15 then
            player:Say("The worst is over, I think")
        elseif mdata.CodeinePillsConsumed <= 18 then
            player:Say("I want to live... I need to push on...")
        end
    end
end

Events.EveryHours.Add(PillElimination)