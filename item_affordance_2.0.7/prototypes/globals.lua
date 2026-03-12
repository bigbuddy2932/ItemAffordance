_G.COMPONENT_ORDER = ".[COMPONENT]"

_G.DATA_UPDATE_DELAY = mods["boblibrary"] ~= nil or mods["quality"] ~= nil
_G.DATA_FINAL_DELAY = mods["space-exploration"] ~= nil

--sets of items that can be interchanged simply, used in both stages
_G.item_affordance_allowed_item_groups = {}
_G.item_affordance_entity_type_lookup = {}
item_affordance_allowed_item_groups["rail-signal-component"] = {"rail-chain-signal", "rail-signal"}
item_affordance_allowed_item_groups["passive-logistic-container-component"] = {"passive-provider", "storage"}
item_affordance_allowed_item_groups["active-logistic-container-component"] = {"active-provider", "requester", "buffer"}
item_affordance_allowed_item_groups["all-logistic-container-component"] = {}
for _, name in ipairs(item_affordance_allowed_item_groups["passive-logistic-container-component"]) do
  table.insert(item_affordance_allowed_item_groups["all-logistic-container-component"], name)
end
for _, name in ipairs(item_affordance_allowed_item_groups["active-logistic-container-component"]) do
  table.insert(item_affordance_allowed_item_groups["all-logistic-container-component"], name)
end

item_affordance_logistic_order = {}
item_affordance_logistic_order["passive-provider"] = "a"
item_affordance_logistic_order["storage"] = "a"
item_affordance_logistic_order["active-provider"] = "b"
item_affordance_logistic_order["requester"] = "b"
item_affordance_logistic_order["buffer"] = "b"

item_affordance_allowed_item_groups["basic-circuit-network-component"] = {"arithmetic-combinator", "decider-combinator", "constant-combinator", "power-switch", "programmable-speaker", "display-panel"}

item_affordance_allowed_item_groups["aai-control-structure"] = {"tile-scan", "zone-scan", "zone-control", "unit-scan"}
item_affordance_entity_type_lookup["zone-control"] = "roboport"

if mods["aai-programmable-vehicles"] then
  table.insert(item_affordance_allowed_item_groups["aai-control-structure"], "unit-control")
  item_affordance_entity_type_lookup["unit-control"] = "roboport"
  table.insert(item_affordance_allowed_item_groups["aai-control-structure"], "unitdata-scan")
  table.insert(item_affordance_allowed_item_groups["aai-control-structure"], "unitdata-control")
  item_affordance_entity_type_lookup["unitdata-control"] = "roboport"
  table.insert(item_affordance_allowed_item_groups["aai-control-structure"], "path-scan")
  table.insert(item_affordance_allowed_item_groups["aai-control-structure"], "path-control")
  item_affordance_entity_type_lookup["path-control"] = "roboport"
end

if mods["Flow Control"] then
    item_affordance_entity_type_lookup["pipe-elbow"] = "storage-tank"
    item_affordance_entity_type_lookup["pipe-straight"] = "storage-tank"
    item_affordance_entity_type_lookup["pipe-junction"] = "storage-tank"
end

-- types of logistic containers
_G.item_affordance_logistic_container_types = {
    {prefix = "", postfix = "-chest"}
}

if mods["aai-containers"] then
  table.insert(item_affordance_logistic_container_types, {prefix = "aai-strongbox-", postfix = ""})
  table.insert(item_affordance_logistic_container_types, {prefix = "aai-storehouse-", postfix = ""})
  table.insert(item_affordance_logistic_container_types, {prefix = "aai-warehouse-", postfix = ""})
end

if mods["angelsaddons-storage"] then
  table.insert(item_affordance_logistic_container_types, {prefix = "angels-silo-", postfix = ""})
  table.insert(item_affordance_logistic_container_types, {prefix = "angels-warehouse-", postfix = ""})
end

if mods["Warehousing"] then
  table.insert(item_affordance_logistic_container_types, {prefix = "storehouse-", postfix = ""})
  table.insert(item_affordance_logistic_container_types, {prefix = "warehouse-", postfix = ""})
end

if mods["boblogistics"] then
  table.insert(item_affordance_logistic_container_types, {prefix = "bob-", postfix = "-chest-2"})
  table.insert(item_affordance_logistic_container_types, {prefix = "bob-", postfix = "-chest-3"})
end

--belt tiers, only used in prototype stage
_G.item_affordance_belt_tiers = {
    {prefix = ""},
    {prefix = "fast-"},
    {prefix = "express-"}
}

if mods["space-age"] then
    table.insert(item_affordance_belt_tiers, {prefix = "turbo-"})
end

if mods["space-exploration"] then
    table.insert(item_affordance_belt_tiers, {prefix = "se-space-"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-black-"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-blue-", base_override = "se-deep-space-transport-belt-black"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-cyan-", base_override = "se-deep-space-transport-belt-black"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-green-", base_override = "se-deep-space-transport-belt-black"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-magenta-", base_override = "se-deep-space-transport-belt-black"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-red-", base_override = "se-deep-space-transport-belt-black"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-white-", base_override = "se-deep-space-transport-belt-black"})
    table.insert(item_affordance_belt_tiers, {prefix = "se-deep-space-", postfix = "-yellow-", base_override = "se-deep-space-transport-belt-black"})
end

if mods["5dim_transport"] then
    if mods["space-age"] == nil then
        table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-04"})
    end
    table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-05"})
    table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-06"})
    table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-07"})
    table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-08"})
    table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-09"})
    table.insert(item_affordance_belt_tiers, {prefix = "5d-", postfix = "-10"})
end

if mods["more-belts"] then
    table.insert(item_affordance_belt_tiers, {prefix = "ddi-", postfix = "-mk4-"})
    table.insert(item_affordance_belt_tiers, {prefix = "ddi-", postfix = "-mk5-"})
    table.insert(item_affordance_belt_tiers, {prefix = "ddi-", postfix = "-mk6-"})
    table.insert(item_affordance_belt_tiers, {prefix = "ddi-", postfix = "-mk7-"})
    table.insert(item_affordance_belt_tiers, {prefix = "ddi-", postfix = "-mk8-"})
end

if mods["promethium-belts"] or mods["promethium-belts-rebalance"] then
    table.insert(item_affordance_belt_tiers, {prefix = "promethium-"})
end

if mods["boblogistics"] then
    table.insert(item_affordance_belt_tiers, {prefix = "bob-basic-"})
    table.insert(item_affordance_belt_tiers, {prefix = "bob-turbo-"})
    table.insert(item_affordance_belt_tiers, {prefix = "bob-ultimate-"})
end