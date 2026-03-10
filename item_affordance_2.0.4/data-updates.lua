require("prototypes.globals")

if mods["boblibrary"] ~= nil then
    require("prototypes.data.rebalance-belt-costs").data_rebalance()
    require("prototypes.data.component-logistic-container-updates")
    require("prototypes.data.component-pipe-updates").data()
    if mods["elevated-rails"] then
        require("prototypes.data.component-rail-updates").data()
    end
    require("prototypes.data.component-simple-updates").data()
end

require("prototypes.data.component-belt-updates")
require("prototypes.data.rebalance-belt-costs").data_updates_rebalance()
require("prototypes.data.component-pipe-updates").data_updates()
if mods["elevated-rails"] then
    require("prototypes.data.component-rail-updates").data_updates()
end
require("prototypes.data.component-simple-updates").data_updates()
