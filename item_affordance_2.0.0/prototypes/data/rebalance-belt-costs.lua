local recipes = data.raw.recipe
local items = data.raw.item

local function multiplyRecipieBatch(recipe, cost_mult, result_mult)
    if not recipe then
        return
    end

    if recipe.energy_required then
        recipe.energy_required = recipe.energy_required * cost_mult
    else
        recipe.energy_required = 0.5 * cost_mult
    end

    if recipe.overload_multiplier then
        recipe.overload_multiplier = recipe.overload_multiplier * cost_mult
    end

    if recipe.ingredients then
        for _, ingredient in ipairs(recipe.ingredients) do
            if ingredient.amount then
                ingredient.amount = ingredient.amount * cost_mult
            end
        end
    end

    if recipe.results then
        for _, result in ipairs(recipe.results) do
            if result.amount then
                result.amount = result.amount * result_mult
            end
            if result.amount_min then
                result.amount_min = result.amount_min * result_mult
            end
            if result.amount_max then
                result.amount_max = result.amount_max * result_mult
            end
        end
    end
end

return {
    data_rebalance = function()
        local recipe = recipes["transport-belt"]
        if recipe then
            multiplyRecipieBatch(recipe, 6, 5)
            if items["copper-plate"] then
               table.insert(recipe.ingredients, {type ="item", name = "copper-plate", amount = 2})
            end
        end

        recipe = recipes["fast-transport-belt"]
        if recipe then
            multiplyRecipieBatch(recipe, 12, 10)
            if items["electronic-circuit"] then
                table.insert(recipe.ingredients, {type ="item", name = "electronic-circuit", amount = 1})
            end
        end

        recipe = recipes["express-transport-belt"]
        if recipe then
            multiplyRecipieBatch(recipe, 36, 30)
            if items["advanced-circuit"] then
                table.insert(recipe.ingredients, {type ="item", name = "advanced-circuit", amount = 5})
            end
        end

        if mods["space-age"] then
            recipe = recipes["turbo-transport-belt"]
            multiplyRecipieBatch(recipe, 60, 50)
            if items["processing-unit"] then
                table.insert(recipe.ingredients, {type ="item", name = "processing-unit", amount = 7})
            end
        end
    end,
    data_updates_rebalance = function()
        if mods["space-exploration"] then
            local recipe = recipes["se-space-transport-belt"]
            if recipe then
                multiplyRecipieBatch(recipe, 12, 10)
                if items["advanced-circuit"] then
                    table.insert(recipe.ingredients, {type ="item", name = "advanced-circuit", amount = 2})
                end
            end

            recipe = recipes["se-deep-space-transport-belt-black"]
            if recipe then
                multiplyRecipieBatch(recipe, 12, 10)
                if items["se-heavy-assembly"] then
                    table.insert(recipe.ingredients, {type ="item", name = "se-heavy-assembly", amount = 1})
                end
                if items["se-naquium-cube"] then
                    table.insert(recipe.ingredients, {type ="item", name = "se-naquium-cube", amount = 2})
                end
            end
        end
    end
}
