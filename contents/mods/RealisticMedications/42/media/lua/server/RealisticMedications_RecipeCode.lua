--This file will be used to dictate variety of drug Recipes that are available in the mod.
require "RecipeCode"

RLSMRecipe =  {}
RLSMRecipe.GetItemTypes = {}
RLSMRecipe.OnCanPerform = {}
RLSMRecipe.Oncreate = {}
RLSMRecipe = RLSMRecipe or {}
RLSMRecipe.OnTest = {}

local codeinelist = {
    "RealisticMedications.Codeine8mg500mg",
    "RealisticMedications.Codeine15mg500mg",
    "RealisticMedications.Codeine30mg500mg",
}

function Recipe.OnCreate.OpenCodeinePills8mg(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems()
    local results = craftRecipeData:getAllCreatedItems()


end