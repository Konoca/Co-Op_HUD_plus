local mod = CoopHUDplus

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.active_item,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.active_item.book_correction_offset.X end,
        Display = function() return 'Book Correction Offset (X): ' .. mod.config.active_item.book_correction_offset.X end,
        OnChange = function(n) mod.config.active_item.book_correction_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.active_item,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return mod.config.active_item.book_correction_offset.Y end,
        Display = function() return 'Book Correction Offset (Y): ' .. mod.config.active_item.book_correction_offset.Y end,
        OnChange = function(n) mod.config.active_item.book_correction_offset.Y = n end,
    }
)

for i = 0, 1, 1 do
    ModConfigMenu.AddSpace(mod.MCM.title, mod.MCM.categories.active_item)
    ModConfigMenu.AddTitle(mod.MCM.title, mod.MCM.categories.active_item, 'Slot '..i+1)
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return mod.config.active_item[i].pos.X end,
            Display = function() return 'Pos (X): ' .. mod.config.active_item[i].pos.X end,
            OnChange = function(n) mod.config.active_item[i].pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return mod.config.active_item[i].pos.Y end,
            Display = function() return 'Pos (Y): ' .. mod.config.active_item[i].pos.Y end,
            OnChange = function(n) mod.config.active_item[i].pos.Y = n end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            Minimum = 0.0,
            -- Maximum = 100.0,
            CurrentSetting = function() return tonumber(string.format('%.0f', mod.config.active_item[i].scale.X * 100)) end,
            Display = function() return 'Scale: ' .. string.format('%.0f', mod.config.active_item[i].scale.X * 100) .. '%' end,
            OnChange = function(n) mod.config.active_item[i].scale = Vector(n/100, n/100) end,
        }
    )

    ModConfigMenu.AddText(mod.MCM.title, mod.MCM.categories.active_item, 'Chargebar')
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return mod.config.active_item[i].chargebar.pos.X end,
            Display = function() return 'Pos (X): ' .. mod.config.active_item[i].chargebar.pos.X end,
            OnChange = function(n) mod.config.active_item[i].chargebar.pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return mod.config.active_item[i].chargebar.pos.Y end,
            Display = function() return 'Pos (Y): ' .. mod.config.active_item[i].chargebar.pos.Y end,
            OnChange = function(n) mod.config.active_item[i].chargebar.pos.Y = n end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function() return mod.config.active_item[i].chargebar.display end,
            Display = function()
                return 'Display: ' .. (mod.config.active_item[i].chargebar.display and 'on' or 'off')
            end,
            OnChange = function(b) mod.config.active_item[i].chargebar.display = b end,
        }
    )
    ModConfigMenu.AddSetting(
        mod.MCM.title,
        mod.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function() return mod.config.active_item[i].chargebar.stay_on_right end,
            Display = function()
                return 'Stay on right side: ' .. (mod.config.active_item[i].chargebar.stay_on_right and 'on' or 'off')
            end,
            OnChange = function(b) mod.config.active_item[i].chargebar.stay_on_right = b end,
        }
    )
end
