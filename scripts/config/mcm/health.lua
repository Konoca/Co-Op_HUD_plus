local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return mod.config.health.ignore_curse end,
        Display = function() return 'Ignore Curse of the Unknown: ' .. (mod.config.health.ignore_curse and 'on' or 'off') end,
        OnChange = function(b) mod.config.health.ignore_curse = b end,
    }
)
ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.health)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.health.pos.X end,
        Display = function() return 'Pos (X): ' .. mod.config.health.pos.X end,
        OnChange = function(n) mod.config.health.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.health.pos.Y end,
        Display = function() return 'Pos (Y): ' .. mod.config.health.pos.Y end,
        OnChange = function(n) mod.config.health.pos.Y = n end,
    }
)
ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.health)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.health.hearts_per_row end,
        Display = function() return 'Hearts per row: ' .. mod.config.health.hearts_per_row end,
        OnChange = function(n) mod.config.health.hearts_per_row = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.health.space_between_hearts end,
        Display = function() return 'Offset (X): ' .. mod.config.health.space_between_hearts end,
        OnChange = function(n) mod.config.health.space_between_hearts = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.health.space_between_rows end,
        Display = function() return 'Offset (Y): ' .. mod.config.health.space_between_rows end,
        OnChange = function(n) mod.config.health.space_between_rows = n end,
    }
)
