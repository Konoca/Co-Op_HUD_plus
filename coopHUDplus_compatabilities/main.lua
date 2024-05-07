local mods = {
    {
        file = require('coopHUDplus_compatabilities.epiphany.main'),
        condition = function() return Epiphany ~= nil end,
    },
}

local function loadModCallbacks(_)
    for _, mod in pairs(mods) do
        if mod.condition() then
            print(mod.file)
            mod.file()
        end
    end
end

CoopHUDplus:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, loadModCallbacks)
