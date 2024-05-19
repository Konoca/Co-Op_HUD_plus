local fonts = {}
for key, _ in pairs(CoopHUDplus.PATHS.FONTS) do
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
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, CoopHUDplus.config.fonts.timer) end,
        Display = function() return 'Timer: ' .. CoopHUDplus.config.fonts.timer end,
        OnChange = function(n) CoopHUDplus.config.fonts.timer = fonts[n] end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, CoopHUDplus.config.fonts.streaks) end,
        Display = function() return 'Streaks: ' .. CoopHUDplus.config.fonts.streaks end,
        OnChange = function(n) CoopHUDplus.config.fonts.streaks = fonts[n] end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, CoopHUDplus.config.fonts.pickups) end,
        Display = function() return 'Pickups: ' .. CoopHUDplus.config.fonts.pickups end,
        OnChange = function(n) CoopHUDplus.config.fonts.pickups = fonts[n] end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, CoopHUDplus.config.fonts.stats) end,
        Display = function() return 'Stats: ' .. CoopHUDplus.config.fonts.stats end,
        OnChange = function(n) CoopHUDplus.config.fonts.stats = fonts[n] end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, CoopHUDplus.config.fonts.pocket_items) end,
        Display = function() return 'Pocket Items: ' .. CoopHUDplus.config.fonts.pocket_items end,
        OnChange = function(n) CoopHUDplus.config.fonts.pocket_items = fonts[n] end,
    }
)
ModConfigMenu.AddSetting(
    CoopHUDplus.MCM.title,
    CoopHUDplus.MCM.categories.fonts,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        Minimum = 1,
        Maximum = #fonts,
        CurrentSetting = function() return getTableIndex(fonts, CoopHUDplus.config.fonts.extra_lives) end,
        Display = function() return 'Extra Lives: ' .. CoopHUDplus.config.fonts.extra_lives end,
        OnChange = function(n) CoopHUDplus.config.fonts.extra_lives = fonts[n] end,
    }
)
