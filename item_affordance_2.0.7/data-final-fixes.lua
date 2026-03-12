require("prototypes.globals")

if DATA_FINAL_DELAY then
    require("prototypes.stages.data")
    require("prototypes.stages.data-updates")
end

log(data.raw.recipe["pipe-to-ground"].energy_required)
if data.raw.recipe["pipe-to-ground-recycling"] then
    log(data.raw.recipe["pipe-to-ground-recycling"].energy_required)
end