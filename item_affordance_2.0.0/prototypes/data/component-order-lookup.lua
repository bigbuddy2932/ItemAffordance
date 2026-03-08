require("prototypes.globals")

_G.item_affordance_component_order = {}
local STEEL_CHEST = "steel-chest"

item_affordance_component_order["se-space-pipe"] = "a[pipe]-c" .. COMPONENT_ORDER .. "-a[se-space-pipe]"

item_affordance_component_order["rail-signal"] = "b[train-automation]-a[train-stop]-" .. COMPONENT_ORDER .. "-c[rail-signal]"
item_affordance_component_order["rail-chain-signal"] = "b[train-automation]-a[train-stop]-" .. COMPONENT_ORDER .. "-c[rail-chain-signal]"

item_affordance_component_order["rail-support"] = "a[rail]-a[rail]-" .. COMPONENT_ORDER .. "-c[rail-support]"
item_affordance_component_order["se-space-rail-support"] = "a[rail]-b[rail-ramp]-" .. COMPONENT_ORDER .. "-f[se-space-rail-support]"
item_affordance_component_order["rail"] = COMPONENT_ORDER .. "-a[rail]"
item_affordance_component_order["se-space-rail"] = "a[rail]-d" .. COMPONENT_ORDER

item_affordance_component_order["medium-electric-pole"] = "a[energy]-b" .. COMPONENT_ORDER .. "-b[medium-electric-pole]"

local item = data.raw["item"]
for _, name in ipairs(item_affordance_allowed_item_groups["all-logistic-container-component"]) do
    for type, fixes in ipairs(item_affordance_logistic_container_types) do
        local key = fixes.prefix .. name .. fixes.postfix

        if fixes.prefix == "warehouse-" then
            item_affordance_component_order[key] = "b[storage]-" .. COMPONENT_ORDER .. item_affordance_logistic_order[name] .. "-b[warehouse]"
        elseif fixes.prefix == "storehouse-" then
            item_affordance_component_order[key] = "b[storage]-" .. COMPONENT_ORDER .. item_affordance_logistic_order[name] .. "-a[storehouse]"
        elseif fixes.prefix == "angels-silo-" then
            item_affordance_component_order[key] = "a[silo]-" .. COMPONENT_ORDER .. item_affordance_logistic_order[name]
        elseif fixes.prefix == "angels-warehouse-" then
            item_affordance_component_order[key] = "a[angels-warehouse]-" .. COMPONENT_ORDER .. item_affordance_logistic_order[name]
        elseif item[key] and item[key].order then
            item_affordance_component_order[key] = item[key].order .. "-" .. COMPONENT_ORDER
        elseif item[STEEL_CHEST] and item[STEEL_CHEST].order then
            item_affordance_component_order[key] = item[STEEL_CHEST].order .. COMPONENT_ORDER .. "[" .. key .. "]"
        else
            item_affordance_component_order[key] = COMPONENT_ORDER .. "[" .. key .. "]"
        end
    end
end


_G.item_affordance_subgroup_order = {}

if settings.startup["elevated-rail-component-base"].value == "rails" then
    item_affordance_subgroup_order["rail-support"] = "rail"
    item_affordance_subgroup_order["rail-ramp"] = "rail"

    item_affordance_subgroup_order["se-space-rail-support"] = "rail"
    item_affordance_subgroup_order["se-space-rail-ramp"] = "rail"
end