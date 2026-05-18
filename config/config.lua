Config = {}

-- Debug mode
Config.Debug = false
Config.DebugEffects = false  -- Set to true to see more information about particle effects

Config.ShopMenu = 'ui' -- ox or built-in ui

Config.ResourceNames = {
    ESX = 'es_extended',
    QBCore = 'qb-core',
}

-- Database settings
Config.Database = {
    AutoExecuteSQL = true, -- Whether to automatically execute the SQL setup on resource start
}   

-- Persistent props settings
Config.PersistentProps = {
    Enabled = true,     -- Whether props persist after server restart
    SaveInterval = 600,  -- How often to save props to database (in seconds)
}

-- Skill Check Configuration
Config.SkillCheck = false -- Master toggle for cooking skill checks

-- Prop Placement Configuration
Config.PropPlacement = {
    MaxDistance = 3.0, -- Maximum distance to place props from player
}

-- Get recipe by name
function Config.GetRecipe(recipeName)
    return Config.Recipes[recipeName]
end

-- Calculate total cooking time for a recipe from cooking flow
function Config.GetTotalCookingTime(recipeName)
    local recipe = Config.Recipes[recipeName]
    if not recipe or not recipe.cookingFlow then return 0 end
    
    local totalTime = 0
    for _, step in ipairs(recipe.cookingFlow) do
        totalTime = totalTime + (step.time or 0)
    end
    
    return totalTime
end

-- Get a specific cooking step from a recipe's cooking flow
function Config.GetCookingStep(recipeName, stepIndex)
    local recipe = Config.Recipes[recipeName]
    if not recipe or not recipe.cookingFlow then return nil end
    
    return recipe.cookingFlow[stepIndex]
end

-- Get total number of cooking steps for a recipe
function Config.GetCookingStepsCount(recipeName)
    local recipe = Config.Recipes[recipeName]
    if not recipe or not recipe.cookingFlow then return 0 end
    
    return #recipe.cookingFlow
end

-- Get prop by model
function Config.GetPropByModel(model)
    local modelHash = model
    
    -- If the model is a string, convert it to hash
    if type(model) == "string" then
        modelHash = joaat(model)
    end
    
    -- Check cooking props first
    for k, v in pairs(Config.CookingProps) do
        local propHash = joaat(v.model)
        if propHash == modelHash or v.model == model then
            return k, v, "cooking"
        end
    end
    
    -- Then check decoration props
    for k, v in pairs(Config.DecorationProps) do
        local propHash = joaat(v.model)
        if propHash == modelHash or v.model == model then
            return k, v, "decoration"
        end
    end
    
    return nil, nil, nil
end

-- Get prop by item
function Config.GetPropByItem(itemName)
    -- Check cooking props first
    for k, v in pairs(Config.CookingProps) do
        if v.item == itemName then
            return k, v, "cooking"
        end
    end
    
    -- Then check decoration props
    for k, v in pairs(Config.DecorationProps) do
        if v.item == itemName then
            return k, v, "decoration"
        end
    end
    
    return nil, nil, nil
end

-- Check if a prop is a decoration prop
function Config.IsDecorationProp(model)
    local modelHash = model
    
    -- If the model is a string, convert it to hash
    if type(model) == "string" then
        modelHash = joaat(model)
    end
    
    for k, v in pairs(Config.DecorationProps) do
        local propHash = joaat(v.model)
        if propHash == modelHash or v.model == model then
            return true
        end
    end
    return false
end
