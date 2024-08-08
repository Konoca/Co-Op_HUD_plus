ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.misc, 'Pickups')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.misc.pickups.pos.X end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.misc.pickups.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.offset.X end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.misc.pickups.offset.X end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.offset.Y end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.misc.pickups.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.text.offset.X end,
        Display = function() return 'Text Offset (X): ' .. CoopHUDplus.config.misc.text.offset.X end,
        OnChange = function(n) CoopHUDplus.config.misc.text.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.text.offset.Y end,
        Display = function() return 'Text Offset (Y): ' .. CoopHUDplus.config.misc.text.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.misc.text.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.bottom_anchor end,
        Display = function() return 'Bottom Anchor: ' .. (CoopHUDplus.config.misc.pickups.bottom_anchor and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.misc.pickups.bottom_anchor = b end,
        Info = {'Anchor Pickups to the bottom of the screen, Pickup Pos will use bottom of screen as origin'},
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.center_anchor end,
        Display = function() return 'Center Anchor: ' .. (CoopHUDplus.config.misc.pickups.center_anchor and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.misc.pickups.center_anchor = b end,
        Info = {'Anchor Pickups to the center of the screen, Pickup Pos will use center of screen as origin'},
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.misc)
ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.misc, 'Difficulty')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.display end,
        Display = function() return 'Display: ' .. (CoopHUDplus.config.misc.difficulty.display and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.misc.difficulty.display = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.misc.difficulty.pos.X end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.pos.X = n
            CoopHUDplus.config.misc.greed_machine.pos.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.misc.difficulty.pos.Y end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.pos.Y = n
            CoopHUDplus.config.misc.greed_machine.pos.Y = n
        end,
    }
)

ModConfigMenu.AddText(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.misc, 'Greed')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.greed_wave_offset.X end,
        Display = function() return 'Text Offset (X): ' .. CoopHUDplus.config.misc.difficulty.greed_wave_offset.X end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.greed_wave_offset.X = n
            CoopHUDplus.config.misc.greed_machine.text_offset.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.greed_wave_offset.Y end,
        Display = function() return 'Text Offset (Y): ' .. CoopHUDplus.config.misc.difficulty.greed_wave_offset.Y end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.greed_wave_offset.Y = n
            CoopHUDplus.config.misc.greed_machine.text_offset.Y = n
        end,
    }
)
