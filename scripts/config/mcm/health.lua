ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.health.ignore_curse end,
        Display = function() return 'Ignore Curse of the Unknown: ' .. (CoopHUDplus.config.health.ignore_curse and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.health.ignore_curse = b end,
    }
)
ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.health)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.health.pos.X end,
        OnChange = function(n) CoopHUDplus.config.health.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.health.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.health.pos.Y = n end,
    }
)
ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.health)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.hearts_per_row end,
        Display = function() return 'Hearts per row: ' .. CoopHUDplus.config.health.hearts_per_row end,
        OnChange = function(n) CoopHUDplus.config.health.hearts_per_row = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.space_between_hearts end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.health.space_between_hearts end,
        OnChange = function(n) CoopHUDplus.config.health.space_between_hearts = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.space_between_rows end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.health.space_between_rows end,
        OnChange = function(n) CoopHUDplus.config.health.space_between_rows = n end,
    }
)
