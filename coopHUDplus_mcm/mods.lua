ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.mods,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.mods.mAPI.override end,
        Display = function() return 'MinimapAPI suggested settings: ' .. (CoopHUDplus.config.mods.mAPI.override and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.mods.mAPI.override = b end,
        Info = {'Your settings will not be overwritten!'},
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.mods,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.mods.EID.override end,
        Display = function() return 'EID suggested settings: ' .. (CoopHUDplus.config.mods.EID.override and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.mods.EID.override = b end,
        Info = {'Your settings will not be overwritten!'},
    }
)
