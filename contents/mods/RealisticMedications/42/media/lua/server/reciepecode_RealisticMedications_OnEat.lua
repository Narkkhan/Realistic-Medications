
RealisticMedications = RealisticMedications

CodeinePillsConsumed = 0

function CodeineConsumption()
    OnEat_CodeineConsumptionFunc()
  
end

function OnEat_CodeineConsumptionFunc()
-- first we will start by setting some base variables
    local player = getPlayer()
    local player_statistics = player:getStats()
    local player_bodydamage = player:getBodyDamage()

-- now we will set the variables for the various pills the player has consumed
    
    --Now increase the codeine increment if the player has consumed codeine
    CodeinePillsConsumed = CodeinePillsConsumed + 1

    print("Amount of Codeine Pills Consumed: "..CodeinePillsConsumed)


    if CodeinePillsConsumed >= 5 then
            if CodeinePillsConsumed < 8 then
                 player:Say("I Feel Sick, I should Stop")
            end
            player_bodydamage:setFoodSicknessLevel(20)
    end
    if CodeinePillsConsumed >= 8 then
            print("player has consumed a total of 8 pills")
            player:Say("I feel Nauseous, I should really stop")
            player_bodydamage:setFoodSicknessLevel(70)
            player_bodydamage:setPanicIncreaseValue(50)
            player_bodydamage:setDiscomfortLevel(50)
            player_statistics:setFatigue(100)
            player_statistics:setPain(50)
            player_statistics:setThirst(60)
    end
    if CodeinePillsConsumed >= 12 then
            player:Say("I feel like I'm going to die")
            player_bodydamage:setFoodSicknessLevel(100)
            player_bodydamage:setOverallBodyHealth(20)
            player_bodydamage:setPanicIncreaseValue(100)
            player_bodydamage:setDiscomfortLevel(100)
            player_statistics:setFatigue(100)
            player_statistics:setPain(100)
    end
    if CodeinePillsConsumed >= 15 then
            player:Say("I can't stay awake...")
            player_bodydamage:setUnhappynessLevel(100)
            player_statistics:setEndurance(0)
            player_statistics:setPanic(100)
            player_statistics:setStress(100)
            player_statistics:setThirst(100)
            player_statistics:setPain(100)
            player_statistics:setFatigue(100)
    end
end

        





