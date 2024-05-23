ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.active_item,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.active_item.book_correction_offset.X end,
        Display = function() return 'Book Correction Offset (X): ' .. CoopHUDplus.config.active_item.book_correction_offset.X end,
        OnChange = function(n) CoopHUDplus.config.active_item.book_correction_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.active_item,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.active_item.book_correction_offset.Y end,
        Display = function() return 'Book Correction Offset (Y): ' .. CoopHUDplus.config.active_item.book_correction_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.active_item.book_correction_offset.Y = n end,
    }
)

for i = 0, 1, 1 do
    ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.active_item)
    ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.active_item, 'Slot '..i+1)
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.active_item[i].pos.X end,
            Display = function() return 'Pos (X): ' .. CoopHUDplus.config.active_item[i].pos.X end,
            OnChange = function(n) CoopHUDplus.config.active_item[i].pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.active_item[i].pos.Y end,
            Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.active_item[i].pos.Y end,
            OnChange = function(n) CoopHUDplus.config.active_item[i].pos.Y = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            Minimum = 0.0,
            -- Maximum = 100.0,
            CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.active_item[i].scale.X * 100)) end,
            Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.active_item[i].scale.X * 100) .. '%' end,
            OnChange = function(n) CoopHUDplus.config.active_item[i].scale = Vector(n/100, n/100) end,
        }
    )

    ModConfigMenu.AddText(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.active_item, 'Chargebar')
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.active_item[i].chargebar.pos.X end,
            Display = function() return 'Pos (X): ' .. CoopHUDplus.config.active_item[i].chargebar.pos.X end,
            OnChange = function(n) CoopHUDplus.config.active_item[i].chargebar.pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.active_item[i].chargebar.pos.Y end,
            Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.active_item[i].chargebar.pos.Y end,
            OnChange = function(n) CoopHUDplus.config.active_item[i].chargebar.pos.Y = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function() return CoopHUDplus.config.active_item[i].chargebar.display end,
            Display = function()
                return 'Display: ' .. (CoopHUDplus.config.active_item[i].chargebar.display and 'on' or 'off')
            end,
            OnChange = function(b) CoopHUDplus.config.active_item[i].chargebar.display = b end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.active_item,
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function() return CoopHUDplus.config.active_item[i].chargebar.stay_on_right end,
            Display = function()
                return 'Stay on right side: ' .. (CoopHUDplus.config.active_item[i].chargebar.stay_on_right and 'on' or 'off')
            end,
            OnChange = function(b) CoopHUDplus.config.active_item[i].chargebar.stay_on_right = b end,
        }
    )
end
