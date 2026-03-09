require("prototypes.globals")
require("prototypes.data.pipette-data")



if settings.startup["belt-components"].value and settings.startup["belt-component-rebalance"].value then
    require("prototypes.data.rebalance-belt-costs").data_rebalance()
end

require("prototypes.data.component-logistic-container-updates")

if settings.startup["pipe-components"].value then
    require("prototypes.data.component-pipe-updates").data()
end

if mods["elevated-rails"] then
    require("prototypes.data.component-rail-updates").data()
end

require("prototypes.data.component-simple-updates").data()
