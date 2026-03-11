require("prototypes.globals")
require("prototypes.data.component-order-lookup")

local pipetteOverrides = data.raw["mod-data"]["item_affordance-entity-to-item-list"].data
local items = data.raw["item"]
local railPlanners = data.raw["rail-planner"]
local modules = data.raw.module
local ITEM_GROUP_PATTERN = "%w*%[[%w-]+%]"
local handledItems = {}

local function itemLookup(itemName)
    local item = items[itemName]
    if item then
        return item
    end
    item = railPlanners[itemName]
    if item then
        return item
    end
    return modules[itemName]
end

local function handleItemSubgroup(item_name)
    local item = itemLookup(item_name)

    if item then
        local new_subgroup = item_affordance_subgroup_order[item_name]
        if new_subgroup then
            item.subgroup = new_subgroup
        end
    end
end

local function handleItemOrder(item_name, sample_result)
    handleItemSubgroup(sample_result)
    local sample_item = itemLookup(sample_result)
    if sample_item and sample_item.order then
        if item_affordance_afforded_order[sample_result] then
            sample_item.order = item_affordance_afforded_order[sample_result]
        end
        if sample_item.order then
            log(sample_result .. ";;" .. sample_item.order)
        end
    end
    if handledItems[item_name] then
        return
    end
    handledItems[item_name] = true

    if string.find(item_name, "transport%-belt") then
        return
    end

    handleItemSubgroup(item_name)
    local item = itemLookup(item_name)

    if item then
        if item_affordance_component_order[item_name] then
            log(item_name .. ";" .. item_affordance_component_order[item_name])
            item.order = item_affordance_component_order[item_name]
            return
        end

        if item.order then
            --try to respect item groups if possible
            local start_index, end_index = string.find(item.order, ITEM_GROUP_PATTERN)
            if start_index and end_index then
                local possible_order = string.sub(item.order, start_index, end_index) .. "-" .. COMPONENT_ORDER
                if end_index + 1 < string.len(item.order) then
                    possible_order = possible_order .. string.sub(item.order, end_index + 1)
                end

                if sample_item then
                    local sample_order = sample_item.order
                    if sample_order then
                        if possible_order < sample_order then
                            item.order = possible_order
                        else
                            log(item_name .. ";" .. COMPONENT_ORDER .. "-" .. item.order)
                            item.order = COMPONENT_ORDER .. "-" .. item.order
                        end
                    else
                        item.order = possible_order
                    end
                else
                    item.order = possible_order
                end
                log(item_name .. ";" .. possible_order)
            else
                log(item_name .. ";" .. COMPONENT_ORDER .. "-" .. item.order)
                item.order = COMPONENT_ORDER .. "-" .. item.order
            end
        else
            log(item_name .. ";" .. COMPONENT_ORDER .. "-unknown")
            --for naughty mod authors who dont give thier items an order
            item.order = COMPONENT_ORDER .. "-unknown"
        end
    end
end

local function recyclePatch(name, details)
    if data.raw["recipe"][name] then
        log("override recycle patch for " .. name)
        data.raw["recipe"][name].results = details.results
        data.raw["recipe"][name].ingredients = details.ingredients
        data.raw["recipe"][name].energy_required = 0.002
        data.raw["recipe"][name].emissions_multiplier = 0
        data.raw["recipe"][name].maximum_productivity = 0
        data.raw["recipe"][name].surface_conditions = nil
        data.raw["recipe"][name].allow_quality = false
        data.raw["recipe"][name].allow_productivity = false
        data.raw["recipe"][name].hide_from_stats = true
        data.raw["recipe"][name].hide_from_bonus_gui = true
        data.raw["recipe"][name].hidden = true
        data.raw["recipe"][name].hidden_in_factoriopedia = true
        data.raw["recipe"][name].auto_recycle = false
        data.raw["recipe"][name].hide_from_signal_gui = true
    end
end

local function recycleRecipe(name, details)
    local recall_name = name .. "-recall"
    if data.raw["recipe"][recall_name] then
        data.raw["recipe"][recall_name] = nil
    end
    local recipe = {
        type = "recipe",
        name = recall_name .. "-recall",
        category = "smelting",
        results = {{amount = details.amount, name = details.result, type = "item"}},
        ingredients = {{amount = 1, type = "item", name = details.ingredient}},
        energy_required = 0.002,
        emissions_multiplier = 0,
        maximum_productivity = 0,
        surface_conditions = nil,
        allow_quality = false,
        allow_productivity = false,
        hide_from_stats = true,
        hide_from_bonus_gui = true,
        hidden = true,
        hidden_in_factoriopedia = true,
        auto_recycle = false,
        hide_from_signal_gui = true
    }

    --this casues the entry to show up in the factoriopedia for some reason
    if mods["quality"] then
        recyclePatch(name .. "-recycling", {
            results = {{amount = details.amount, name = details.result, type = "item"}},
            ingredients = {{amount = 1, type = "item", name = details.ingredient}}
        })
    end

    data:extend({recipe})
end

local fromComponentRecipie = function(result_name, component_name, cost, amount)
    cost = cost or 1
    amount = amount or 1
    local recipe = data.raw["recipe"][result_name]

    if recipe then
        recipe.ingredients = {{amount = cost, type = "item", name = component_name}}
        recipe.category = "crafting"
        -- these items are only used for placement, so i don't think it makes sence to have a time cost
        recipe.energy_required = 0.002
        recipe.emissions_multiplier = 0
        recipe.maximum_productivity = 0
        recipe.surface_conditions = nil
        recipe.allow_quality = false
        recipe.allow_productivity = false
        recipe.hide_from_stats = true
        recipe.hide_from_bonus_gui = true
        recipe.allow_decomposition = true
        recipe.allow_as_intermediate = true
        recipe.allow_intermediates = true
        recipe.auto_recycle = false
        recipe.results = {{amount = amount, name = result_name, type = "item"}}

        if items[result_name] and items[result_name].auto_recycle then
            items[result_name].auto_recycle = false
        end
        recycleRecipe(result_name, {
            ingredient = result_name,
            amount = cost/amount,
            result = component_name
        })
        return recipe
    end
    log("Failed to lookup recipie for " .. result_name)
    return nil
end

local assignComponentToEntity = function(result_type, result_name, component_name, cost)
    cost = cost or 1
    local entity = data.raw[result_type][result_name]
    local component_item = itemLookup(component_name)

    if entity and component_item then
        if settings.startup["affordance-retrieve-base"].value then
            entity.minable.results = {{name = component_name, amount = cost, type = "item"}}
            entity.minable.result = nil
            entity.factoriopedia_alternative = result_name
        end

        if settings.startup["affordance-place-with-base"].value then
            entity.placeable_by = {{item = component_name, count = cost}}
            local afforded_item = itemLookup(result_name)

            if afforded_item then
                pipetteOverrides[result_name] = result_name
            else
                log("Failed to register pipette override for " .. result_name .. " because " .. result_name .. " is a nil item")
            end

            -- an item's order seems to matter to an entity's placeable_by
            handleItemOrder(component_name, result_name)
        end
    elseif settings.startup["affordance-retrieve-base"].value or settings.startup["affordance-place-with-base"].value then
        if component_item == nil then
            log("Failed to assign entity to component for " .. result_name .. " because " .. component_name .. " is a nil item")
        end
        if entity == nil then
            log("Failed to assign entity to component for " .. result_name .. " because it is a nil entity")
        end
    end
end

local attachComponentToItem = function(result_type, result_name, component_name, cost)
    cost = cost or 1
    log(string.format("[%s][%s][%s]", result_type, result_name, component_name))
    assignComponentToEntity(result_type, result_name, component_name, cost)
    fromComponentRecipie(result_name, component_name, cost)
end

local function attachComponentsToItem(component_setting_name, allowed_values, result_type, prefix, postfix)
    prefix = prefix or ""
    postfix = postfix or ""
    local doComponentAffordanceSettingName = string.format("%ss", component_setting_name)
    if settings.startup[doComponentAffordanceSettingName] and not settings.startup[doComponentAffordanceSettingName].value then
        return
    end

    local component_name = settings.startup[string.format("%s-base", component_setting_name)].value

    for _, result_name in ipairs(allowed_values) do
        if result_name ~= component_name then
            local local_type = result_type
            local lookup_type = item_affordance_entity_type_lookup[result_name]
            if lookup_type ~= nil then
                local_type = lookup_type
            end

            if local_type == nil then
                attachComponentToItem(result_name, result_name, component_name)
            else
                attachComponentToItem(local_type, prefix .. result_name .. postfix, prefix .. component_name .. postfix)
            end
        end
    end
end

return {
  fromComponentRecipie = fromComponentRecipie,
  assignComponentToEntity = assignComponentToEntity,
  attachComponentToItem = attachComponentToItem,
  attachComponentsToItem = attachComponentsToItem,
  recyclePatch = recyclePatch,
  itemLookup = itemLookup
}