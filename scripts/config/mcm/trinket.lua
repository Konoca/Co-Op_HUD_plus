local mod = CoopHUDplus

for i = 0, 1, 1 do
    ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.trinket, 'Slot '..i+1)
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.trinket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return mod.config.trinket[i].pos.X end,
            Display = function() return 'Pos (X): ' .. mod.config.trinket[i].pos.X end,
            OnChange = function(n) mod.config.trinket[i].pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.trinket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return mod.config.trinket[i].pos.Y end,
            Display = function() return 'Pos (Y): ' .. mod.config.trinket[i].pos.Y end,
            OnChange = function(n) mod.config.trinket[i].pos.Y = n end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.trinket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            Minimum = 0.0,
            -- Maximum = 100.0,
            CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.trinket[i].scale.X * 100)) end,
            Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.trinket[i].scale.X * 100) .. '%' end,
            OnChange = function(n) mod.config.trinket[i].scale = Vector(n/100, n/100) end,
        }
    )
    ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.trinket)
end
