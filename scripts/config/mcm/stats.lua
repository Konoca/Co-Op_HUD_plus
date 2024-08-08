local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.stats.pos.X end,
        OnChange = function(n) mod.config.stats.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.stats.pos.Y end,
        OnChange = function(n) mod.config.stats.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.offset.X end,
        Display = function() return 'Offset (X): ' .. mod.config.stats.offset.X end,
        OnChange = function(n) mod.config.stats.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.offset.Y end,
        Display = function() return 'Offset (Y): ' .. mod.config.stats.offset.Y end,
        OnChange = function(n) mod.config.stats.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.mirrored_offset.X end,
        Display = function() return 'Mirrored Additional Offset (X): ' .. mod.config.stats.mirrored_offset.X end,
        OnChange = function(n) mod.config.stats.mirrored_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.mirrored_offset.Y end,
        Display = function() return 'Mirrored Additional Offset (Y): ' .. mod.config.stats.mirrored_offset.Y end,
        OnChange = function(n) mod.config.stats.mirrored_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.stats.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.stats.scale.X * 100) .. '%' end,
        OnChange = function(n) mod.config.stats.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.stats)
ModConfigMenu.AddText(mod.MCM.title, mod.MCM.categories.stats, 'Text')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.stats.text.pos.X end,
        OnChange = function(n) mod.config.stats.text.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.stats.text.pos.Y end,
        OnChange = function(n) mod.config.stats.text.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.offset.X end,
        Display = function() return 'Offset (X): ' .. mod.config.stats.text.offset.X end,
        OnChange = function(n) mod.config.stats.text.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.offset.Y end,
        Display = function() return 'Offset (Y): ' .. mod.config.stats.text.offset.Y end,
        OnChange = function(n) mod.config.stats.text.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.twin_offset.X end,
        Display = function() return 'Twin Offset (X): ' .. mod.config.stats.text.twin_offset.X end,
        OnChange = function(n) mod.config.stats.text.twin_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.twin_offset.Y end,
        Display = function() return 'Twin Offset (Y): ' .. mod.config.stats.text.twin_offset.Y end,
        OnChange = function(n) mod.config.stats.text.twin_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.mirrored_offset.X end,
        Display = function() return 'Mirrored Additional Offset (X): ' .. mod.config.stats.text.mirrored_offset.X end,
        OnChange = function(n) mod.config.stats.text.mirrored_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.mirrored_offset.Y end,
        Display = function() return 'Mirrored Additional Offset (Y): ' .. mod.config.stats.text.mirrored_offset.Y end,
        OnChange = function(n) mod.config.stats.text.mirrored_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.lowered_offset.X end,
        Display = function() return 'Lowered Offset (X): ' .. mod.config.stats.text.lowered_offset.X end,
        OnChange = function(n) mod.config.stats.text.lowered_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.lowered_offset.Y end,
        Display = function() return 'Lowered Offset (Y): ' .. mod.config.stats.text.lowered_offset.Y end,
        OnChange = function(n) mod.config.stats.text.lowered_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.stats.text.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.stats.text.scale.X * 100) .. '%' end,
        OnChange = function(n) mod.config.stats.text.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.stats)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        CurrentSetting = function() return mod.config.stats.text.update.frames end,
        Display = function() return 'Update Frames: ' .. mod.config.stats.text.update.frames end,
        OnChange = function(n) mod.config.stats.text.update.frames = n end,
        Info = {'How many frames a stat is being update by will be displayed'}
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.update.offset.X end,
        Display = function() return 'Update Offset (X): ' .. mod.config.stats.text.update.offset.X end,
        OnChange = function(n) mod.config.stats.text.update.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.stats.text.update.offset.Y end,
        Display = function() return 'Update Offset (Y): ' .. mod.config.stats.text.update.offset.Y end,
        OnChange = function(n) mod.config.stats.text.update.offset.Y = n end,
    }
)
