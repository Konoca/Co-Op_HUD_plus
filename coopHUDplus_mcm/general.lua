ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.disable end,
        Display = function() return 'Enable HUD: ' .. (not CoopHUDplus.config.disable and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.disable = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.enable_toggle_hud end,
        Display = function() return 'Enable HUD toggle: ' .. (CoopHUDplus.config.enable_toggle_hud and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.enable_toggle_hud = b end,
        Info = {'Press "h" to toggle between Co-Op HUD+ and the Default HUD'},
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.player_colors end,
        Display = function() return 'Enable Player Colors: ' .. (CoopHUDplus.config.player_colors and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.player_colors = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.colors end,
        Display = function() return 'Enable Stat colors: ' .. (CoopHUDplus.config.stats.text.colors and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.stats.text.colors = b end,
    }
)
ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.general)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.offset.X end,
        Display = function() return 'HUD Offset: ' .. CoopHUDplus.config.offset.X end,
        OnChange = function(n) CoopHUDplus.config.offset = Vector(n, n) end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.mirrored_extra_offset.X end,
        Display = function() return 'P2&4 Additional Offset (X): ' .. CoopHUDplus.config.mirrored_extra_offset.X end,
        OnChange = function(n) CoopHUDplus.config.mirrored_extra_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.mirrored_extra_offset.Y end,
        Display = function() return 'P3&4 Addtional Offset (Y): ' .. CoopHUDplus.config.mirrored_extra_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.mirrored_extra_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.twin_pos.X end,
        Display = function() return 'Twin Pos (X): ' .. CoopHUDplus.config.twin_pos.X end,
        OnChange = function(n) CoopHUDplus.config.twin_pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.twin_pos.Y end,
        Display = function() return 'Twin Pos (Y): ' .. CoopHUDplus.config.twin_pos.Y end,
        OnChange = function(n) CoopHUDplus.config.twin_pos.Y = n end,
    }
)

