ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.inventory.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.inventory.pos.X end,
        OnChange = function(n) CoopHUDplus.config.inventory.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.inventory.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.inventory.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.inventory.pos.Y = n end,
    }
)

ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.inventory.spacing.X end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.inventory.spacing.X end,
        OnChange = function(n) CoopHUDplus.config.inventory.spacing.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.inventory.spacing.Y end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.inventory.spacing.Y end,
        OnChange = function(n) CoopHUDplus.config.inventory.spacing.Y = n end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.inventory)
ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.inventory, 'Bag of Crafting')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.inventory.result_pos.X end,
        Display = function() return 'Result Pos (X): ' .. CoopHUDplus.config.inventory.result_pos.X end,
        OnChange = function(n) CoopHUDplus.config.inventory.result_pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.inventory.result_pos.Y end,
        Display = function() return 'Result Pos (Y): ' .. CoopHUDplus.config.inventory.result_pos.Y end,
        OnChange = function(n) CoopHUDplus.config.inventory.result_pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.active_item,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.inventory.ignore_curse end,
        Display = function()
            return 'Ignore Curse of the Blind: ' .. (CoopHUDplus.config.inventory.ignore_curse and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.inventory.ignore_curse = b end,
    }
)
