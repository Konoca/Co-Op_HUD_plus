local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.streak.pos.X end,
        OnChange = function(n) mod.config.streak.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.streak.pos.Y end,
        OnChange = function(n) mod.config.streak.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.streak.bottom_anchor end,
        Display = function() return 'Bottom Anchor: ' .. (mod.config.streak.bottom_anchor and 'on' or 'off') end,
        OnChange = function(b) mod.config.streak.bottom_anchor = b end,
        Info = {'Anchor Streak to the bottom of the screen, Pos will use bottom of screen as origin'},
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.streak.center_anchor end,
        Display = function() return 'Center Anchor: ' .. (mod.config.streak.center_anchor and 'on' or 'off') end,
        OnChange = function(b) mod.config.streak.center_anchor = b end,
        Info = {'Anchor Pickups to the center of the screen, Pos will use center of screen as origin'},
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.streak)
ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.streak, 'Streak Title')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.name.offset.X end,
        Display = function() return 'Pos (X): ' .. mod.config.streak.name.offset.X end,
        OnChange = function(n) mod.config.streak.name.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.name.offset.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.streak.name.offset.Y end,
        OnChange = function(n) mod.config.streak.name.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.name.box_width end,
        Display = function() return 'Box Width: ' .. mod.config.streak.name.box_width end,
        OnChange = function(n) mod.config.streak.name.box_width = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.streak.name.box_center end,
        Display = function() return 'Box Center: ' .. (mod.config.streak.name.box_center and 'on' or 'off') end,
        OnChange = function(b) mod.config.streak.name.box_center = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.streak.name.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.streak.name.scale.X * 100) .. '%' end,
        OnChange = function(n) mod.config.streak.name.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.streak)
ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.streak, 'Item Description')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.description.offset.X end,
        Display = function() return 'Pos (X): ' .. mod.config.streak.description.offset.X end,
        OnChange = function(n) mod.config.streak.description.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.description.offset.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.streak.description.offset.Y end,
        OnChange = function(n) mod.config.streak.description.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.description.box_width end,
        Display = function() return 'Box Width: ' .. mod.config.streak.description.box_width end,
        OnChange = function(n) mod.config.streak.description.box_width = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.streak.description.box_center end,
        Display = function() return 'Box Center: ' .. (mod.config.streak.description.box_center and 'on' or 'off') end,
        OnChange = function(b) mod.config.streak.description.box_center = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.streak.description.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.streak.description.scale.X * 100) .. '%' end,
        OnChange = function(n) mod.config.streak.description.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.streak)
ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.streak, 'Curse Description')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.curse.offset.X end,
        Display = function() return 'Pos (X): ' .. mod.config.streak.curse.offset.X end,
        OnChange = function(n) mod.config.streak.curse.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.curse.offset.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.streak.curse.offset.Y end,
        OnChange = function(n) mod.config.streak.curse.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.streak.curse.box_width end,
        Display = function() return 'Box Width: ' .. mod.config.streak.curse.box_width end,
        OnChange = function(n) mod.config.streak.curse.box_width = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.streak.curse.box_center end,
        Display = function() return 'Box Center: ' .. (mod.config.streak.curse.box_center and 'on' or 'off') end,
        OnChange = function(b) mod.config.streak.curse.box_center = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.streak,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.streak.curse.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.streak.curse.scale.X * 100) .. '%' end,
        OnChange = function(n) mod.config.streak.curse.scale = Vector(n/100, n/100) end,
    }
)
