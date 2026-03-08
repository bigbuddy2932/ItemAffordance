require("prototypes.globals")

if settings.startup["belt-components"].value then
    require("prototypes.data.component-belt-updates")
    if settings.startup["belt-component-rebalance"].value then
        require("prototypes.data.rebalance-belt-costs").data_updates_rebalance()
    end
end



if settings.startup["pipe-components"].value then
    require("prototypes.data.component-pipe-updates").data_updates()
end

if mods["elevated-rails"] then
    require("prototypes.data.component-rail-updates").data_updates()
end

require("prototypes.data.component-simple-updates").data_updates()
