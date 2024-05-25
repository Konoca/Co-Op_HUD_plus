local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.inventory.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.inventory.pos.X end,
        OnChange = function(n) mod.config.inventory.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.inventory.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.inventory.pos.Y end,
        OnChange = function(n) mod.config.inventory.pos.Y = n end,
    }
)

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.inventory.spacing.X end,
        Display = function() return 'Offset (X): ' .. mod.config.inventory.spacing.X end,
        OnChange = function(n) mod.config.inventory.spacing.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.inventory.spacing.Y end,
        Display = function() return 'Offset (Y): ' .. mod.config.inventory.spacing.Y end,
        OnChange = function(n) mod.config.inventory.spacing.Y = n end,
    }
)

ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.inventory)
ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.inventory, 'Bag of Crafting')
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.inventory.result_pos.X end,
        Display = function() return 'Result Pos (X): ' .. mod.config.inventory.result_pos.X end,
        OnChange = function(n) mod.config.inventory.result_pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.inventory,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.inventory.result_pos.Y end,
        Display = function() return 'Result Pos (Y): ' .. mod.config.inventory.result_pos.Y end,
        OnChange = function(n) mod.config.inventory.result_pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.active_item,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.inventory.ignore_curse end,
        Display = function()
            return 'Ignore Curse of the Blind: ' .. (mod.config.inventory.ignore_curse and 'on' or 'off')
        end,
        OnChange = function(b) mod.config.inventory.ignore_curse = b end,
    }
)
