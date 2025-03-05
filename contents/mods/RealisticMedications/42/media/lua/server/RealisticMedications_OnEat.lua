--- This is the file that will be used to handle the consumption of the Codeine Pills and the side effects for now.
--- This will be expanded upon in the future to include other medications and their effects.



--- @type Item_OnEat
function CodeineConsumptionFunc(item, character, amount)
    local player = character -- Use the character that ate the pills 
    local mdata = player:getModData() -- Get the mod data for the player
    local player_stats = player:getStats() -- Get the Players Statistics to enable them to be manipulated later
    local player_bd = player:getBodyDamage() -- Get the players body damage to enable them to be manipulated later
    local player_bh = player_bd:getOverallBodyHealth() -- Obtains the players overall body health to enable it to be manipulated later
    local DrugSnapShot = mdata.player_TS -- Get the timestamp of when the player took the pills
    local DrugEffectTime = mdata.player_EffectTime -- Get the timestamp of when the pills will take effect
    local DrugTaken = mdata.Player_DrugTaken -- has the drug been taken?
    

    
    -- This "or 0" is required because initially, the variable will be nil (non-existent) so you
    -- have to set it to a default value. Basically "true or 0" will return true, and "false or 0" will return 0.
    mdata.CodeinePillsConsumed = (mdata.CodeinePillsConsumed or 0) + 1
    mdata.PillSpeechCounter = (mdata.PillSpeechCounter or 0) + 2
    mdata.PlayerTimeSurvived = (mdata.PlayerTimeSurvived or 0)
   
    local codeinepillsEaten = mdata.CodeinePillsConsumed -- set this once we've verified it cant be null and retrieved the value!
    local pillSpeechCounter = mdata.PillSpeechCounter
    mdata.DrugSnapshot = DrugSnapShot
    mdata.DrugEffectTime = DrugEffectTime
    mdata.DrugActive = DrugTaken
    --------------FIX REQUIRED ON DRUGTAKEN ---------------------------------------


    -- Change this to else if, because otherwise it will always return true!
    -- Also, we have to reverse the if tree, because >= 1 will ALWAYS return true, even if they've eaten 1000000 and should theoretically die!!! If else will then skip the rest of the tree and go right to "end".
    -- So you could put >= 15 at the top adn then >= 1 at the bottom, but I prefer to invert the statement, so
    -- it is LESS THAN which works just as well.

    
    
    if codeinepillsEaten <= 1 then
         if pillSpeechCounter <= 1 and codeinepillsEaten == 1 then 
            player:Say("I feel a little better")
            
        --Printing is only for debugging purposes, remove this or comment it out when done 
            print(pillSpeechCounter)
         end
         print("It Currently is "..DrugSnapShot.."the pills should take effect in"..DrugEffectTime)
         
        
        
        --time survived test print for purposes of seeing if capturing it and adding it for future side effect development
    
        --Printing is only for debugging purposes, remove this or comment it out when done 
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        print("Player Current Body health is "..player_bh )
    elseif codeinepillsEaten <= 5 then
          if codeinepillsEaten <=5 and pillSpeechCounter <=5 then 
            player:Say("I feel a little sick")
            
        --Printing is only for debugging purposes, remove this or comment it out when done 
            print(pillSpeechCounter)
          end
        player_bd:setFoodSicknessLevel(20)
        
        --Printing is only for debugging purposes, remove this or comment it out when done  
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
    elseif codeinepillsEaten > 5 and mdata.CodeinePillsConsumed < 8 then
        player:Say("I Feel Sick, I should Stop")
        player_bd:setFoodSicknessLevel(30)
        
        --Printing is only for debugging purposes, remove this or comment it out when done 
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
    elseif codeinepillsEaten <= 8 then
        print("player has consumed AT LEAST 8 pills")
        player:Say("My stomach is killing me...")
        player_bd:setFoodSicknessLevel(50)
        player_bd:getBodyPart(BodyPartType.Torso_Lower):SetHealth(50)
    elseif codeinepillsEaten <= 12 then
        
        --Printing is only for debugging purposes, remove this or comment it out when done 
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("I feel like I'm going to die")
        player_bd:setFoodSicknessLevel(75)
        player_bd:setPanicIncreaseValue(75)
        player_bd:setDiscomfortLevel(50)
        player_stats:setFatigue(100)
        player_stats:setPain(100)
        player_bd:getBodyPart(BodyPartType.Torso_Upper):SetHealth(45)
        player_bd:getBodyPart(BodyPartType.Torso_Lower):SetHealth(45)
    elseif codeinepillsEaten <= 15 then
        
        --Printing is only for debugging purposes, remove this or comment it out when done 
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("I can't stay awake...")
        player_bd:getBodyPart(BodyPartType.Torso_Upper):SetHealth(25)
        player_bd:getBodyPart(BodyPartType.Torso_Lower):SetHealth(45)

        --stages after this are considered the endgame stages
        --players are intentionally at the point of taking pills, and the messages are to try and emulate the characters mindset 
        --They are going to die if they continue to take the pills beyond this point if the continue their behaviour, we are trying to implore them to stop and think, alongside show the severity of their actions
        
    elseif codeinepillsEaten <= 16 then
        player:playSound("Deathiscoming1")
        player:Say("I'm sorry, I'm so sorry")
        player:Say("*Muffled Crying*") 
        
    elseif codeinepillsEaten <= 17 then
        player:Say("I don't want to go alone...")
    
    elseif codeinepillsEaten <=18 then 
        player:Say("Not long left now...")
        player:Say("*sniffling*")

    elseif codeinepillsEaten <=19 then
        player:Say("Mom, Dad, I love you")
        player:Say("*Muffled Crying*")

    elseif codeinepillsEaten >=20 then
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
        player:Say("*Gurgling Sounds*")
        player_bd:setOverallBodyHealth(0)

        --Final stage of the codeine overdose, the player dies. 

    elseif codeinepillsEaten <=100 then
        player:Say("I have taken "..mdata.CodeinePillsConsumed.." pills")
        print("player has consumed "..mdata.CodeinePillsConsumed.." pills")
    else
        mdata.Player_DrugTaken = false
        -- Kill the player instantly at this point 
        -- Here means they've eaten far too many. More than 15 to be exact!
        
    end

    

end
---Function Requires Fixed----
function DrugEffectTimeStamp(character)
    local TS = getPlayer():getHoursSurvived()
    local mdata = getPlayer():getModData()
    local DrugTaken 
    mdata.player_TS = TS
    mdata.player_EffectTime = TS + 4
    DrugTaken = mdata.Player_DrugTaken
    print("Status of Drug Taken is "..DrugTaken.." ")
 
    if mdata.DrugTaken == true then
        print("the current time of Player_TS is "..mdata.player_TS)
        print("")
        print("the current time of Player_EffectTime is "..mdata.player_EffectTime)
        if mdata.player_TS == mdata.player_EffectTime then
            print("The pills have taken effect")
        end
    end
    


end


---@type Item_OnEat
function BenzoConsumption(item, character, amount)
    local player = character -- Use the character that ate the pills 
    local mdata = player:getModData() -- Get the mod data for the player
    local player_stats = player:getStats() -- Get the Players Statistics to enable them to be manipulated later
    local player_bd = player:getBodyDamage() -- Get the players body damage to enable them to be manipulated later
    local player_bh = player_bd:getOverallBodyHealth() -- Obtains the players overall body health to enable it to be manipulated later

    mdata.BenzoPillsConsumed = (mdata.BenzoPillsConsumed or 0) + 1

    local benzopillsEaten = mdata.BenzoPillsConsumed

    if player_stats:getPanic() == 50 then
        player:Say("I can't shake the feeling of dread")
    
    end

    if benzopillsEaten <=1 then
        

        --Printing is only for debugging purposes, remove this or comment it out when done 
        print("player has consumed "..mdata.BenzoPillsConsumed.." pills")
        print("Player Current Body health is "..player_bh )
    end
    
end

function SpeechCancellation()
    local player = getPlayer()
    local mdata = player:getModData()
    local timeofday = getGameTime():getTimeOfDay()
    if mdata.PillSpeechCounter and mdata.PillSpeechCounter > 0 then
        mdata.PillSpeechCounter = mdata.PillSpeechCounter -1
        print("Current Time is "..timeofday)
        print("Speech Counter has decreased to "..mdata.PillSpeechCounter)
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

    if mdata.BenzoPillsConsumed and mdata.BenzoPillsConsumed > 0 then
        mdata.BenzoDegradation = mdata.BenzoPillsConsumed -1
        mdata.BenzoPillsConsumed = mdata.BenzoDegradation
        print("Current Time is "..timeofday)
        print("Benzo Value has decreased to "..mdata.BenzoDegradation)
        if mdata.BenzoPillsConsumed <= 1 then
            player:Say("I think it's all out of my system")
        elseif mdata.BenzoPillsConsumed <=8 then
            player:Say("I feel a little better, I don't think I should overdo it like that in the future")
        elseif mdata.BenzoPillsConsumed <= 12 then
            player:Say("I think I might make it through this...")
        elseif mdata.BenzoPillsConsumed <= 15 then
            player:Say("The worst is over, I think")
        elseif mdata.BenzoPillsConsumed <= 18 then
            player:Say("I want to live... I need to push on...")
        end
    end
end

Events.EveryOneMinute.Add(DrugEffectTimeStamp)
Events.EveryTenMinutes.Add(SpeechCancellation)
Events.EveryHours.Add(PillElimination)