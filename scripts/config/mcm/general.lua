local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.disable end,
        Display = function() return 'Enable HUD: ' .. (not mod.config.disable and 'on' or 'off') end,
        OnChange = function(b) mod.config.disable = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.display_during_pause end,
        Display = function() return 'Enable HUD on pause: ' .. (mod.config.display_during_pause and 'on' or 'off') end,
        OnChange = function(b) mod.config.display_during_pause = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.enable_toggle_hud end,
        Display = function() return 'Enable HUD toggle: ' .. (mod.config.enable_toggle_hud and 'on' or 'off') end,
        OnChange = function(b) mod.config.enable_toggle_hud = b end,
        Info = {'Press "h" to toggle between Co-Op HUD+ and the Default HUD'},
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.player_colors end,
        Display = function() return 'Enable Player Colors: ' .. (mod.config.player_colors and 'on' or 'off') end,
        OnChange = function(b) mod.config.player_colors = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.stats.text.colors end,
        Display = function() return 'Enable Stat colors: ' .. (mod.config.stats.text.colors and 'on' or 'off') end,
        OnChange = function(b) mod.config.stats.text.colors = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.items.colors end,
        Display = function() return 'Enable Item colors: ' .. (mod.config.items.colors and 'on' or 'off') end,
        OnChange = function(b) mod.config.items.colors = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.timer.display end,
        Display = function() return 'Enable Timer: ' .. (mod.config.timer.display and 'on' or 'off') end,
        OnChange = function(b) mod.config.timer.display = b end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.general)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.offset.X end,
        Display = function() return 'HUD Offset: ' .. mod.config.offset.X end,
        OnChange = function(n) mod.config.offset = Vector(n, n) end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.mirrored_extra_offset.X end,
        Display = function() return 'P2&4 Additional Offset (X): ' .. mod.config.mirrored_extra_offset.X end,
        OnChange = function(n) mod.config.mirrored_extra_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.mirrored_extra_offset.Y end,
        Display = function() return 'P3&4 Addtional Offset (Y): ' .. mod.config.mirrored_extra_offset.Y end,
        OnChange = function(n) mod.config.mirrored_extra_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.twin_pos.X end,
        Display = function() return 'Twin Pos (X): ' .. mod.config.twin_pos.X end,
        OnChange = function(n) mod.config.twin_pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.twin_pos.Y end,
        Display = function() return 'Twin Pos (Y): ' .. mod.config.twin_pos.Y end,
        OnChange = function(n) mod.config.twin_pos.Y = n end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.general)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return true end,
        Display = function() return 'Reset settings' end,
        OnChange = function(_) mod.ResetConfig() end,
    }
)

