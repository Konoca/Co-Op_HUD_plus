local mod = CoopHUDplus
local Utils = mod.Utils

-- TODO every time you change fonts, the memory used goes up and doesn't go back down
-- For now, warning is given

local fonts = {}
for key, _ in pairs(mod.PATHS.FONTS) do
    table.insert(fonts, key)
end

local function getTableIndex(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return i
    end
  end

  return 0
end

ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, mod.config.fonts.timer) end,
        Display = function() return 'Timer: ' .. mod.config.fonts.timer end,
        OnChange = function(n) mod.config.fonts.timer = fonts[n] Utils.LoadFonts() end,
        Info = {'Warning! Game might lag after changing fonts, please restart your game after changing this setting.'}
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, mod.config.fonts.streaks) end,
        Display = function() return 'Streaks: ' .. mod.config.fonts.streaks end,
        OnChange = function(n) mod.config.fonts.streaks = fonts[n] Utils.LoadFonts() end,
        Info = {'Warning! Game might lag after changing fonts, please restart your game after changing this setting.'}
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, mod.config.fonts.pickups) end,
        Display = function() return 'Pickups: ' .. mod.config.fonts.pickups end,
        OnChange = function(n) mod.config.fonts.pickups = fonts[n] Utils.LoadFonts() end,
        Info = {'Warning! Game might lag after changing fonts, please restart your game after changing this setting.'}
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, mod.config.fonts.stats) end,
        Display = function() return 'Stats: ' .. mod.config.fonts.stats end,
        OnChange = function(n) mod.config.fonts.stats = fonts[n] Utils.LoadFonts() end,
        Info = {'Warning! Game might lag after changing fonts, please restart your game after changing this setting.'}
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, mod.config.fonts.pocket_items) end,
        Display = function() return 'Pocket Items: ' .. mod.config.fonts.pocket_items end,
        OnChange = function(n) mod.config.fonts.pocket_items = fonts[n] Utils.LoadFonts() end,
        Info = {'Warning! Game might lag after changing fonts, please restart your game after changing this setting.'}
    }
)
ModConfigMenu.AddSetting(
    mod.MCM.title,
    mod.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, mod.config.fonts.extra_lives) end,
        Display = function() return 'Extra Lives: ' .. mod.config.fonts.extra_lives end,
        OnChange = function(n) mod.config.fonts.extra_lives = fonts[n] Utils.LoadFonts() end,
        Info = {'Warning! Game might lag after changing fonts, please restart your game after changing this setting.'}
    }
)
