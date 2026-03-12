require("prototypes.globals")
require("prototypes.data.pipette-data")
require("prototypes.data.reclaim-data")

log(data.raw.recipe["pipe-to-ground"].energy_required)
if data.raw.recipe["pipe-to-ground-recycling"] then
    log(data.raw.recipe["pipe-to-ground-recycling"].energy_required)
end

if not DATA_UPDATE_DELAY and not DATA_FINAL_DELAY then
    require("prototypes.stages.data")
end

log(data.raw.recipe["pipe-to-ground"].energy_required)
if data.raw.recipe["pipe-to-ground-recycling"] then
    log(data.raw.recipe["pipe-to-ground-recycling"].energy_required)
end
