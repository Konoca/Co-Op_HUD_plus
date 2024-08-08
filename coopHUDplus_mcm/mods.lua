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

ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.mods,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.mods.EPIPHANY.hud_element_pos.X end,
        Display = function() return 'Epiphany HUD Y: ' .. CoopHUDplus.config.mods.EPIPHANY.hud_element_pos.X end,
        OnChange = function(n) CoopHUDplus.config.mods.EPIPHANY.hud_element_pos.X = n end,
        Info = {'Used for rendering any additional HUD elements for Epiphany Tarnished characters'},
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.mods,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.mods.EPIPHANY.hud_element_pos.Y end,
        Display = function() return 'Epiphany HUD Y: ' .. CoopHUDplus.config.mods.EPIPHANY.hud_element_pos.Y end,
        OnChange = function(n) CoopHUDplus.config.mods.EPIPHANY.hud_element_pos.Y = n end,
        Info = {'Used for rendering any additional HUD elements for Epiphany Tarnished characters'},
    }
)
