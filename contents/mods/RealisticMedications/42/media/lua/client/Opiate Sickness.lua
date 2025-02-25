local function Opiates_Make_Me_Sick()

    local player = getPlayer()
    local bodyDamage = player:getBodyDamage()
    local playertakepills = player:getModData().TakePills -- Assuming this is how you get the variable
  
    if player:isAlive() then
        if playertakepills then
            player:Say("I feel sick")
            player:getBodyDamage():setFoodSicknessLevel(1)

        end
    end

end

Events.EveryTenMinutes.Add(Opiates_Make_Me_Sick)