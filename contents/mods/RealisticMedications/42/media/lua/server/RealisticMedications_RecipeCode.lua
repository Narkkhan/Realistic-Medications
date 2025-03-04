--This file will be used to dictate variety of drug Recipes that are available in the mod.
require "RecipeCode"

RLSMRecipe =  {}
RLSMRecipe.GetItemTypes = {}
RLSMRecipe.OnCanPerform = {}
RLSMRecipe.Oncreate = {}
RLSMRecipe = RLSMRecipe or {}
RLSMRecipe.OnTest = {}

local drugslibrary = {
    "RealisticMedications.Codeine8mg500mg",
    "RealisticMedications.Codeine15mg500mg",
    "RealisticMedications.Codeine30mg500mg",
    "RealisticMedications.Diazepam2mg",
    "RealisticMedications.Diazepam5mg",
    "RealisticMedications.Diazepam10mg",
}

function Recipe.OnCreate.OpenCodeinePills8mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end

function Recipe.OnCreate.OpenCodeinePills15mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end

function Recipe.OnCreate.OpenCodeinePills30mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end

function Recipe.OnCreate.OpenDiazepam2mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end

function Recipe.OnCreate.OpenDiazepam5mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end

function Recipe.OnCreate.OpenDiazepam10mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end