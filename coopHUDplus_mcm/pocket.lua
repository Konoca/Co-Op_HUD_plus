ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.pocket, 'Text')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.pocket.text.display end,
        Display = function()
            return 'Display: ' .. (CoopHUDplus.config.pocket.text.display and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.pocket.text.display = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.pocket.text.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.pocket.text.pos.X end,
        OnChange = function(n) CoopHUDplus.config.pocket.text.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.pocket.text.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.pocket.text.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.pocket.text.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.pocket.text.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.pocket.text.scale.X * 100) .. '%' end,
        OnChange = function(n) CoopHUDplus.config.pocket.text.scale = Vector(n/100, n/100) end,
    }
)

ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.pocket)
ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.pocket, 'Chargebar')
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.pocket.chargebar.display end,
        Display = function()
            return 'Display: ' .. (CoopHUDplus.config.pocket.chargebar.display and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.pocket.chargebar.display = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.pocket.chargebar.stay_on_right end,
        Display = function()
            return 'Stay on right side: ' .. (CoopHUDplus.config.pocket.chargebar.stay_on_right and 'on' or 'off')
        end,
        OnChange = function(b) CoopHUDplus.config.pocket.chargebar.stay_on_right = b end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.pocket.chargebar.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.pocket.chargebar.pos.X end,
        OnChange = function(n) CoopHUDplus.config.pocket.chargebar.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.pocket.chargebar.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.pocket.chargebar.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.pocket.chargebar.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.pocket,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 0.0,
        -- Maximum = 100.0,
        CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.pocket.chargebar.scale.X * 100)) end,
        Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.pocket.chargebar.scale.X * 100) .. '%' end,
        OnChange = function(n) CoopHUDplus.config.pocket.chargebar.scale = Vector(n/100, n/100) end,
    }
)

for i = 0, 3, 1 do
    ModConfigMenu.AddSpace(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.pocket)
    ModConfigMenu.AddTitle(CoopHUDplus.MCM.title, CoopHUDplus.MCM.categories.pocket, 'Slot '..i+1)
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.pocket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.pocket[i].pos.X end,
            Display = function() return 'Pos (X): ' .. CoopHUDplus.config.pocket[i].pos.X end,
            OnChange = function(n) CoopHUDplus.config.pocket[i].pos.X = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.pocket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            CurrentSetting = function() return CoopHUDplus.config.pocket[i].pos.Y end,
            Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.pocket[i].pos.Y end,
            OnChange = function(n) CoopHUDplus.config.pocket[i].pos.Y = n end,
        }
    )
    ModConfigMenu.AddSetting(
        CoopHUDplus.MCM.title,
        CoopHUDplus.MCM.categories.pocket,
        {
            Type = ModConfigMenu.OptionType.NUMBER,
            Minimum = 0.0,
            -- Maximum = 100.0,
            CurrentSetting = function() return tonumber(string.format('%.0f', CoopHUDplus.config.pocket[i].scale.X * 100)) end,
            Display = function() return 'Scale: ' .. string.format('%.0f', CoopHUDplus.config.pocket[i].scale.X * 100) .. '%' end,
            OnChange = function(n) CoopHUDplus.config.pocket[i].scale = Vector(n/100, n/100) end,
        }
    )
end
