for i = 0, 1, 1 do
    ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.trinket, 'Slot '..i+1)
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.trinket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.trinket[i].pos.X end,
            Display = function() return 'Pos (X): ' .. CoopHUDplus.config.trinket[i].pos.X end,
            OnChange = function(n) CoopHUDplus.config.trinket[i].pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.trinket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.trinket[i].pos.Y end,
            Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.trinket[i].pos.Y end,
            OnChange = function(n) CoopHUDplus.config.trinket[i].pos.Y = n end,
        }
    )
    ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.trinket)
end
