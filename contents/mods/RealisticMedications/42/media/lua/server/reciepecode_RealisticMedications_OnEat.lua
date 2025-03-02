
--- @type Item_OnEat
function CodeineConsumptionFunc(item, character, amount)
    -- Use the character that ate the pills instead of getPlayer() here!
    local player = character
    -- Getting the player's mod data
    local mdata = player:getModData()
    local player_stats = player:getStats()
    local player_bd = player:getBodyDamage()
    local player_bh = player_bd:getOverallBodyHealth()
    


    -- Increment the codeine consumed.
    
    -- This "or 0" is required because initially, the variable will be nil (non-existent) so you
    -- have to set it to a default value. Basically "true or 0" will return true, and "false or 0" will return 0.
    mdata.CodeinePillsConsumed = (mdata.CodeinePillsConsumed or 0) + 1
   
    local pillsEaten = mdata.CodeinePillsConsumed -- set this once we've verified it cant be null and retrieved the value!

    -- Change this to else if, because otherwise it will always return true!
    -- Also, we have to reverse the if tree, because >= 1 will ALWAYS return true, even if they've eaten 1000000 and should theoretically die!!! If else will then skip the rest of the tree and go right to "end".
    -- So you could put >= 15 at the top adn then >= 1 at the bottom, but I prefer to invert the statement, so
    -- it is LESS THAN which works just as well.
    if pillsEaten <= 1 then
        player:Say("I feel a little better")
        player_bd:setPainReduction(20)
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        print("Player Current Body health is "..player_bh )
    elseif pillsEaten <= 5 then
        player_bd:setFoodSicknessLevel(20)
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
    elseif pillsEaten > 5 and mdata.CodeinePillsConsumed < 8 then
        player:Say("I Feel Sick, I should Stop")
        player_bd:setFoodSicknessLevel(20)
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
        player_bd:setUnhappynessLevel(100)
        player_stats:setEndurance(0)
        player_stats:setPanic(100)
        player_stats:setStress(100)
        player_stats:setThirst(100)
        player_stats:setPain(100)
        player_stats:setFatigue(100)
    elseif pillsEaten <= 16 then
        
    elseif pillsEaten <= 17 then


    elseif pillsEaten >=20 then
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("*Gurgling Sounds*")
        player_bd:setOverallBodyHealth(0)

    elseif pillsEaten <=100 then
        player:Say("I have taken "..mdata.CodeinePillsConsumed.." pills")
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")

        -- Kill the player instantly at this point LOL
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
        end
    end
end

Events.EveryHours.Add(PillElimination)