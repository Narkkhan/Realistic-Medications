

function CodeineEliminationTest()
local player = Character
local player_statistics = player:getStats()
local player_bodydamage = player:getBodyDamage()

    if mdata.CodeinePillsConsumed >= 1 then
        print("Currently consumed "..mdata.CodeinePillsConsumed.." pills")
        mdata.CodeinePillsConsumed = mdata. CodeinePillsConsumed - 1
        


    end
    Events.EveryTenMinutes.Add(CodeineEliminationTest)
end
