ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.stats.pos.X end,
        OnChange = function(n) CoopHUDplus.config.stats.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.stats.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.offset.X end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.stats.offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.offset.Y end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.stats.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.mirrored_offset.X end,
        Display = function() return 'Mirrored Additional Offset (X): ' .. CoopHUDplus.config.stats.mirrored_offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.mirrored_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.mirrored_offset.Y end,
        Display = function() return 'Mirrored Additional Offset (Y): ' .. CoopHUDplus.config.stats.mirrored_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.mirrored_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.stats.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.stats.scale.X * 100) .. '%' end,
        OnChange = function(n) CoopHUDplus.config.stats.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.stats)
ModConfigMenu.AddText(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.stats, 'Text')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.stats.text.pos.X end,
        OnChange = function(n) CoopHUDplus.config.stats.text.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.stats.text.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.text.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.offset.X end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.stats.text.offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.text.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.offset.Y end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.stats.text.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.text.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.twin_offset.X end,
        Display = function() return 'Twin Offset (X): ' .. CoopHUDplus.config.stats.text.twin_offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.text.twin_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.twin_offset.Y end,
        Display = function() return 'Twin Offset (Y): ' .. CoopHUDplus.config.stats.text.twin_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.text.twin_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.mirrored_offset.X end,
        Display = function() return 'Mirrored Additional Offset (X): ' .. CoopHUDplus.config.stats.text.mirrored_offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.text.mirrored_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.mirrored_offset.Y end,
        Display = function() return 'Mirrored Additional Offset (Y): ' .. CoopHUDplus.config.stats.text.mirrored_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.text.mirrored_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.lowered_offset.X end,
        Display = function() return 'Lowered Offset (X): ' .. CoopHUDplus.config.stats.text.lowered_offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.text.lowered_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.lowered_offset.Y end,
        Display = function() return 'Lowered Offset (Y): ' .. CoopHUDplus.config.stats.text.lowered_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.text.lowered_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.stats.text.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.stats.text.scale.X * 100) .. '%' end,
        OnChange = function(n) CoopHUDplus.config.stats.text.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.stats)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.update.frames end,
        Display = function() return 'Update Frames: ' .. CoopHUDplus.config.stats.text.update.frames end,
        OnChange = function(n) CoopHUDplus.config.stats.text.update.frames = n end,
        Info = {'How many frames a stat is being update by will be displayed'}
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.update.offset.X end,
        Display = function() return 'Update Offset (X): ' .. CoopHUDplus.config.stats.text.update.offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.text.update.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.update.offset.Y end,
        Display = function() return 'Update Offset (Y): ' .. CoopHUDplus.config.stats.text.update.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.text.update.offset.Y = n end,
    }
)
