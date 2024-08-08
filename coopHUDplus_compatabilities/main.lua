local mods = {
    {
        file = require('coopHUDplus_compatabilities.epiphany.main'),
        condition = function() return Epiphany ~= nil end,
    },
    {
        file = require('coopHUDplus_compatabilities.jericho.main'),
        condition = function() return _JERICHO_MOD ~= nil end,
    }
}

local function loadModCallbacks(_)
    for _, mod in pairs(mods) do
        if mod.condition() then
            mod.file()
        end
    end
end

CoopHUDplus:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, loadModCallbacks)
