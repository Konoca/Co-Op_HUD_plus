local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.items.display end,
        Display = function()
            return 'Display: ' .. (mod.config.items.display and 'on' or 'off')
        end,
        OnChange = function(b) mod.config.items.display = b end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.items_per_player end,
        Display = function() return 'Items to display: ' .. mod.config.items.items_per_player end,
        OnChange = function(n) mod.config.items.items_per_player = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.items.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.items.scale.X * 100) .. '%' end,
        OnChange = function(n)
            mod.config.items.scale = Vector(n/100, n/100)
        end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.items)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.items.pos.X end,
        OnChange = function(n) mod.config.items.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.items.pos.Y end,
        OnChange = function(n) mod.config.items.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.offset.X end,
        Display = function() return 'Item Offet (X): ' .. mod.config.items.offset.X end,
        OnChange = function(n) mod.config.items.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.offset.Y end,
        Display = function() return 'Item Offset (Y): ' .. mod.config.items.offset.Y end,
        OnChange = function(n) mod.config.items.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.player_offset.X end,
        Display = function() return 'Player Offet (X): ' .. mod.config.items.player_offset.X end,
        OnChange = function(n) mod.config.items.player_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.items.player_offset.Y end,
        Display = function() return 'Player Offset (Y): ' .. mod.config.items.player_offset.Y end,
        OnChange = function(n) mod.config.items.player_offset.Y = n end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.items)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.items.anchors.X == 1 end,
        Display = function()
            return 'Anchor to right-side: ' .. (mod.config.items.anchors.X == 1 and 'on' or 'off')
        end,
        OnChange = function(b) mod.config.items.anchors.X = b and 1 or 0 end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.items.anchors.Y end,
        Display = function()
            return 'Anchor to bottom: ' .. (mod.config.items.anchors.Y == 1 and 'on' or 'off')
        end,
        OnChange = function(b) mod.config.items.anchors.Y = b and 1 or 0 end,
    }
)
