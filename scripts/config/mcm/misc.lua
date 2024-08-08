local mod = CoopHUDplus

ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.misc, 'Pickups')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.pickups.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.misc.pickups.pos.X end,
        OnChange = function(n) mod.config.misc.pickups.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.pickups.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.misc.pickups.pos.Y end,
        OnChange = function(n) mod.config.misc.pickups.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.pickups.offset.X end,
        Display = function() return 'Offset (X): ' .. mod.config.misc.pickups.offset.X end,
        OnChange = function(n) mod.config.misc.pickups.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.pickups.offset.Y end,
        Display = function() return 'Offset (Y): ' .. mod.config.misc.pickups.offset.Y end,
        OnChange = function(n) mod.config.misc.pickups.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.text.offset.X end,
        Display = function() return 'Text Offset (X): ' .. mod.config.misc.text.offset.X end,
        OnChange = function(n) mod.config.misc.text.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.text.offset.Y end,
        Display = function() return 'Text Offset (Y): ' .. mod.config.misc.text.offset.Y end,
        OnChange = function(n) mod.config.misc.text.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.misc.text.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.misc.text.scale.X * 100) .. '%' end,
        OnChange = function(n) mod.config.misc.text.scale = Vector(n/100, n/100) end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.misc.pickups.bottom_anchor end,
        Display = function() return 'Bottom Anchor: ' .. (mod.config.misc.pickups.bottom_anchor and 'on' or 'off') end,
        OnChange = function(b) mod.config.misc.pickups.bottom_anchor = b end,
        Info = {'Anchor Pickups to the bottom of the screen, Pickup Pos will use bottom of screen as origin'},
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.misc.pickups.center_anchor end,
        Display = function() return 'Center Anchor: ' .. (mod.config.misc.pickups.center_anchor and 'on' or 'off') end,
        OnChange = function(b) mod.config.misc.pickups.center_anchor = b end,
        Info = {'Anchor Pickups to the center of the screen, Pickup Pos will use center of screen as origin'},
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.misc)
ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.misc, 'Difficulty')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.misc.difficulty.display end,
        Display = function() return 'Display: ' .. (mod.config.misc.difficulty.display and 'on' or 'off') end,
        OnChange = function(b) mod.config.misc.difficulty.display = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.difficulty.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.misc.difficulty.pos.X end,
        OnChange = function(n)
            mod.config.misc.difficulty.pos.X = n
            mod.config.misc.greed_machine.pos.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.difficulty.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.misc.difficulty.pos.Y end,
        OnChange = function(n)
            mod.config.misc.difficulty.pos.Y = n
            mod.config.misc.greed_machine.pos.Y = n
        end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.misc.difficulty.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.misc.difficulty.scale.X * 100) .. '%' end,
        OnChange = function(n)
            mod.config.misc.difficulty.scale = Vector(n/100, n/100)
            mod.config.misc.greed_machine.scale = Vector(n/100, n/100)
        end,
    }
)

ModConfigMenu.AddText(mod.MCM.title, mod.MCM.categories.misc, 'Greed')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.difficulty.greed_wave_offset.X end,
        Display = function() return 'Text Offset (X): ' .. mod.config.misc.difficulty.greed_wave_offset.X end,
        OnChange = function(n)
            mod.config.misc.difficulty.greed_wave_offset.X = n
            mod.config.misc.greed_machine.text_offset.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.misc.difficulty.greed_wave_offset.Y end,
        Display = function() return 'Text Offset (Y): ' .. mod.config.misc.difficulty.greed_wave_offset.Y end,
        OnChange = function(n)
            mod.config.misc.difficulty.greed_wave_offset.Y = n
            mod.config.misc.greed_machine.text_offset.Y = n
        end,
    }
)
