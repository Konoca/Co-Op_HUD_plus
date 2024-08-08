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
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.trinket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            Minimum = 0.0,
            -- Maximum = 100.0,
            CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.trinket[i].scale.X * 100)) end,
            Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.trinket[i].scale.X * 100) .. '%' end,
            OnChange = function(n) CoopHUDplus.config.trinket[i].scale = Vector(n/100, n/100) end,
        }
    )
    ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.trinket)
end
