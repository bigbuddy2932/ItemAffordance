local componentUtil = require("component-util")
local recipes = data.raw.recipe

return {
    data = function()
        if not settings.startup["pipe-components"].value then
            return
        end

        if data.raw.technology["foundry"] and mods["5dim_core"] == nil then
            local effects = data.raw.technology["foundry"].effects
            local removeIndex = nil
            local maxIndex = nil
            for index, value in ipairs(effects) do
                if value.type == "unlock-recipe" and value.recipe == "casting-pipe-to-ground" then
                    removeIndex = index
                end
                maxIndex = index
            end
            if removeIndex ~= nil then
                effects[removeIndex] = nil
                if removeIndex ~= maxIndex then
                    effects[removeIndex] = effects[maxIndex]
                    effects[maxIndex] = nil
                end
            end
            recipes["casting-pipe-to-ground"] = nil
        end

        if mods["Flow Control"] then
            componentUtil.attachComponentToItem("storage-tank", "pipe-elbow", "pipe")
            componentUtil.attachComponentToItem("storage-tank", "pipe-junction", "pipe")
            componentUtil.attachComponentToItem("storage-tank", "pipe-straight", "pipe")
        end

        if mods["5dim_transport"] then
            componentUtil.assignComponentToEntity("pipe-to-ground", "5d-pipe-to-ground-mk1-30", "pipe", 32)
            componentUtil.fromComponentRecipie("5d-pipe-to-ground-mk1-30", "pipe", 16)

            componentUtil.assignComponentToEntity("pipe-to-ground", "5d-pipe-to-ground-mk1-50", "pipe", 52)
            componentUtil.fromComponentRecipie("5d-pipe-to-ground-mk1-50", "pipe", 26)
        end
    end,
    data_updates = function()
        if not settings.startup["pipe-components"].value then
            return
        end
        componentUtil.assignComponentToEntity("pipe-to-ground", "pipe-to-ground", "pipe", 4)
        componentUtil.fromComponentRecipie("pipe-to-ground", "pipe", 8, 2)

        if mods["space-exploration"] then
            componentUtil.assignComponentToEntity("pipe-to-ground", "se-space-pipe-to-ground", "se-space-pipe", 5)
            componentUtil.fromComponentRecipie("pipe-to-ground", "se-space-pipe", 10, 2)

            componentUtil.attachComponentToItem("storage-tank", "se-space-pipe-long-j-3", "se-space-pipe", 2)
            componentUtil.attachComponentToItem("storage-tank", "se-space-pipe-long-j-5", "se-space-pipe", 3)
            componentUtil.attachComponentToItem("storage-tank", "se-space-pipe-long-j-7", "se-space-pipe", 4)
            componentUtil.attachComponentToItem("storage-tank", "se-space-pipe-long-s-9", "se-space-pipe", 5)
            componentUtil.attachComponentToItem("storage-tank", "se-space-pipe-long-s-15", "se-space-pipe", 8)
        end
    end
}