if ModConfigMenu == nil then return end

-- TODO
-- https://github.com/Zamiell/isaac-mod-config-menu/tree/main

local title = 'Co-Op HUD+'
local categories = {
    general = 'General',
}

-- General Settings
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return CoopHUDplus.config.disable
        end,
        Display = function()
            return 'Enable HUD: ' .. (CoopHUDplus.config.disable and 'on' or 'off')
        end,
        OnChange = function(b)
            CoopHUDplus.config.disable = b
        end,
    }
)

-- TODO fix to start at 5 and not 0
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.SCROLL,
        CurrentSetting = function()
            return CoopHUDplus.config.offset.X / 2
        end,
        Display = function()
            return 'HUD Offset: $scroll' .. math.floor(CoopHUDplus.config.offset.X / 2)
        end,
        OnChange = function(n)
            CoopHUDplus.config.offset = Vector(n*2, n*2)
        end,
    }
)

-- TODO mirrored extra offset as 2 options, X and Y
-- TODO twin pos as 2 options, X and Y

ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return CoopHUDplus.config.enable_toggle_hud
        end,
        Display = function()
            return 'Enable HUD toggle: ' .. (CoopHUDplus.config.enable_toggle_hud and 'on' or 'off')
        end,
        OnChange = function(b)
            CoopHUDplus.config.enable_toggle_hud = b
        end,
        Info = {
            'Press "h" to toggle between CoopHUDplus and Default HUD'
        }
    }
)
