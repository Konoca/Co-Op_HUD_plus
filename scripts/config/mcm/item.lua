ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.items.display end,
        Display = function()
            return 'Display: ' .. (CoopHUDplus.config.items.display and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.items.display = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.items_per_player end,
        Display = function() return 'Items to display: ' .. CoopHUDplus.config.items.items_per_player end,
        OnChange = function(n) CoopHUDplus.config.items.items_per_player = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.items.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.items.scale.X * 100) .. '%' end,
        OnChange = function(n)
            CoopHUDplus.config.items.scale = Vector(n/100, n/100)
        end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.items)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.items.pos.X end,
        OnChange = function(n) CoopHUDplus.config.items.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.items.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.items.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.offset.X end,
        Display = function() return 'Item Offet (X): ' .. CoopHUDplus.config.items.offset.X end,
        OnChange = function(n) CoopHUDplus.config.items.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.offset.Y end,
        Display = function() return 'Item Offset (Y): ' .. CoopHUDplus.config.items.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.items.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.player_offset.X end,
        Display = function() return 'Player Offet (X): ' .. CoopHUDplus.config.items.player_offset.X end,
        OnChange = function(n) CoopHUDplus.config.items.player_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.items.player_offset.Y end,
        Display = function() return 'Player Offset (Y): ' .. CoopHUDplus.config.items.player_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.items.player_offset.Y = n end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.items)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.items.anchors.X == 1 end,
        Display = function()
            return 'Anchor to right-side: ' .. (CoopHUDplus.config.items.anchors.X == 1 and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.items.anchors.X = b and 1 or 0 end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.items,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.items.anchors.Y end,
        Display = function()
            return 'Anchor to bottom: ' .. (CoopHUDplus.config.items.anchors.Y == 1 and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.items.anchors.Y = b and 1 or 0 end,
    }
)
