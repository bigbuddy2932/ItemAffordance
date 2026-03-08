local componentUtil = require("component-util")

return {
    data = function()
        if settings.startup["rail-signal-component-base"].value ~= "disabled" then
            componentUtil.attachComponentsToItem("rail-signal-component",
                item_affordance_allowed_item_groups["rail-signal-component"]
            )
        end

        if settings.startup["basic-circuit-network-component-base"].value ~= "disabled" then
            componentUtil.attachComponentsToItem("basic-circuit-network-component",
                item_affordance_allowed_item_groups["basic-circuit-network-component"]
            )
        end

        if settings.startup["electric-pole-components"].value then
            componentUtil.attachComponentToItem("electric-pole", "big-electric-pole", "medium-electric-pole", 2)
        end

        if mods["angelsaddons-storage"] and data.raw.item["angels-silo"] then
            for i = 1, 6, 1 do
                componentUtil.attachComponentToItem("container", "angels-silo-ore" .. i, "angels-silo")
            end
            componentUtil.attachComponentToItem("container", "angels-silo-coal", "angels-silo")
        end

        if mods["aai-programmable-structures"] and settings.startup["aai-control-structure-component-base"].value ~= "disabled" then
            componentUtil.attachComponentsToItem("aai-control-structure-component",
                item_affordance_allowed_item_groups["aai-control-structure"],
                "radar"
            )
        end
    end,
    data_updates = function()
        if mods["dredgeworks"] then
            if settings.startup["electric-pole-components"].value then
                componentUtil.attachComponentToItem("electric-pole", "wire-buoy", "medium-electric-pole", 2)
            end
        end

        if mods["kry-inserters"] then
            componentUtil.attachComponentToItem("inserter", "burner-long-inserter", "burner-inserter")
            componentUtil.attachComponentToItem("inserter", "long-handed-inserter", "inserter")
            componentUtil.attachComponentToItem("inserter", "long-fast-inserter", "fast-inserter")
            componentUtil.attachComponentToItem("inserter", "long-bulk-inserter", "bulk-inserter")
            componentUtil.attachComponentToItem("inserter", "long-stack-inserter", "stack-inserter")

            if mods["dredgeworks"] then
                componentUtil.attachComponentToItem("inserter", "floating-burner-long-inserter", "floating-burner-inserter")
                componentUtil.attachComponentToItem("inserter", "floating-long-handed-inserter", "floating-inserter")
                componentUtil.attachComponentToItem("inserter", "floating-long-fast-inserter", "floating-fast-inserter")
                componentUtil.attachComponentToItem("inserter", "floating-long-bulk-inserter", "floating-bulk-inserter")
                componentUtil.attachComponentToItem("inserter", "floating-long-stack-inserter", "floating-stack-inserter")
            end
        end
    end
}