ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.streak.pos.X end,
        OnChange = function(n) CoopHUDplus.config.streak.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.streak.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.streak.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.streak.bottom_anchor end,
        Display = function() return 'Bottom Anchor: ' .. (CoopHUDplus.config.streak.bottom_anchor and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.streak.bottom_anchor = b end,
        Info = {'Anchor Streak to the bottom of the screen, Pos will use bottom of screen as origin'},
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.streak.center_anchor end,
        Display = function() return 'Center Anchor: ' .. (CoopHUDplus.config.streak.center_anchor and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.streak.center_anchor = b end,
        Info = {'Anchor Pickups to the center of the screen, Pos will use center of screen as origin'},
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.streak)
ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.streak, 'Streak Title')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.name.offset.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.streak.name.offset.X end,
        OnChange = function(n) CoopHUDplus.config.streak.name.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.name.offset.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.streak.name.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.streak.name.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.name.box_width end,
        Display = function() return 'Box Width: ' .. CoopHUDplus.config.streak.name.box_width end,
        OnChange = function(n) CoopHUDplus.config.streak.name.box_width = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.streak.name.box_center end,
        Display = function() return 'Box Center: ' .. (CoopHUDplus.config.streak.name.box_center and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.streak.name.box_center = b end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.streak)
ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.streak, 'Item Description')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.description.offset.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.streak.description.offset.X end,
        OnChange = function(n) CoopHUDplus.config.streak.description.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.description.offset.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.streak.description.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.streak.description.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.description.box_width end,
        Display = function() return 'Box Width: ' .. CoopHUDplus.config.streak.description.box_width end,
        OnChange = function(n) CoopHUDplus.config.streak.description.box_width = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.streak.description.box_center end,
        Display = function() return 'Box Center: ' .. (CoopHUDplus.config.streak.description.box_center and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.streak.description.box_center = b end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.streak)
ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.streak, 'Curse Description')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.curse.offset.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.streak.curse.offset.X end,
        OnChange = function(n) CoopHUDplus.config.streak.curse.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.curse.offset.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.streak.curse.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.streak.curse.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.streak.curse.box_width end,
        Display = function() return 'Box Width: ' .. CoopHUDplus.config.streak.curse.box_width end,
        OnChange = function(n) CoopHUDplus.config.streak.curse.box_width = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.streak.curse.box_center end,
        Display = function() return 'Box Center: ' .. (CoopHUDplus.config.streak.curse.box_center and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.streak.curse.box_center = b end,
    }
)
