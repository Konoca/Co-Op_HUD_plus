if ModConfigMenu == nil then return end
-- https://github.com/Zamiell/isaac-mod-config-menu/tree/main

local title = 'Co-Op HUD+'
local categories = {
    general = 'General',
    mods = 'Mods',
    misc = 'Misc.',
    health = 'Health',
    stats = 'Stats',
    active_item = 'Active Items',
    pocket = 'Pocket Items',
    trinket = 'Trinket',
    inventory = 'Inventory',
}


-- General Settings
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.disable end,
        Display = function() return 'Enable HUD: ' .. (not CoopHUDplus.config.disable and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.disable = b end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.enable_toggle_hud end,
        Display = function() return 'Enable HUD toggle: ' .. (CoopHUDplus.config.enable_toggle_hud and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.enable_toggle_hud = b end,
        Info = {'Press "h" to toggle between Co-Op HUD+ and the Default HUD'},
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.player_colors end,
        Display = function() return 'Enable Player Colors: ' .. (CoopHUDplus.config.player_colors and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.player_colors = b end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.stats.text.colors end,
        Display = function() return 'Enable Stat colors: ' .. (CoopHUDplus.config.stats.text.colors and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.stats.text.colors = b end,
    }
)
ModConfigMenu.AddSpace(title, categories.general)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.offset.X end,
        Display = function() return 'HUD Offset: ' .. CoopHUDplus.config.offset.X end,
        OnChange = function(n) CoopHUDplus.config.offset = Vector(n, n) end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.mirrored_extra_offset.X end,
        Display = function() return 'P2&4 Additional Offset (X): ' .. CoopHUDplus.config.mirrored_extra_offset.X end,
        OnChange = function(n) CoopHUDplus.config.mirrored_extra_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.mirrored_extra_offset.Y end,
        Display = function() return 'P3&4 Addtional Offset (Y): ' .. CoopHUDplus.config.mirrored_extra_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.mirrored_extra_offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.twin_pos.X end,
        Display = function() return 'Twin Pos (X): ' .. CoopHUDplus.config.twin_pos.X end,
        OnChange = function(n) CoopHUDplus.config.twin_pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.general,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.twin_pos.Y end,
        Display = function() return 'Twin Pos (Y): ' .. CoopHUDplus.config.twin_pos.Y end,
        OnChange = function(n) CoopHUDplus.config.twin_pos.Y = n end,
    }
)


-- Mod Settings
ModConfigMenu.AddSetting(
    title,
    categories.mods,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.mods.mAPI.override end,
        Display = function() return 'MinimapAPI suggested settings: ' .. (CoopHUDplus.config.mods.mAPI.override and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.mods.mAPI.override = b end,
        Info = {'Your settings will not be overwritten!'},
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.mods,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.mods.EID.override end,
        Display = function() return 'EID suggested settings: ' .. (CoopHUDplus.config.mods.EID.override and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.mods.EID.override = b end,
        Info = {'Your settings will not be overwritten!'},
    }
)


-- Stat settings
ModConfigMenu.AddSetting(
    title,
    categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.stats.pos.X end,
        OnChange = function(n) CoopHUDplus.config.stats.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.stats.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.offset.X end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.stats.offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.offset.Y end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.stats.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.mirrored_offset.X end,
        Display = function() return 'Mirrored Additional Offset (X): ' .. CoopHUDplus.config.stats.mirrored_offset.X end,
        OnChange = function(n) CoopHUDplus.config.stats.mirrored_offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.stats,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.stats.mirrored_offset.Y end,
        Display = function() return 'Mirrored Additional Offset (Y): ' .. CoopHUDplus.config.stats.mirrored_offset.Y end,
        OnChange = function(n) CoopHUDplus.config.stats.mirrored_offset.Y = n end,
    }
)


-- Misc Settings
ModConfigMenu.AddTitle(title, categories.misc, 'Pickups')
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.misc.pickups.pos.X end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.pos.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.misc.pickups.pos.Y end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.pos.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.offset.X end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.misc.pickups.offset.X end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.offset.Y end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.misc.pickups.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.misc.pickups.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.text.offset.X end,
        Display = function() return 'Text Offset (X): ' .. CoopHUDplus.config.misc.text.offset.X end,
        OnChange = function(n) CoopHUDplus.config.misc.text.offset.X = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.text.offset.Y end,
        Display = function() return 'Text Offset (Y): ' .. CoopHUDplus.config.misc.text.offset.Y end,
        OnChange = function(n) CoopHUDplus.config.misc.text.offset.Y = n end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.bottom_anchor end,
        Display = function() return 'Bottom Anchor: ' .. (CoopHUDplus.config.misc.pickups.bottom_anchor and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.misc.pickups.bottom_anchor = b end,
        Info = {'Anchor Pickups to the bottom of the screen, Pickup Pos will use bottom of screen as origin'},
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.misc.pickups.center_anchor end,
        Display = function() return 'Center Anchor: ' .. (CoopHUDplus.config.misc.pickups.center_anchor and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.misc.pickups.center_anchor = b end,
        Info = {'Anchor Pickups to the center of the screen, Pickup Pos will use center of screen as origin'},
    }
)

ModConfigMenu.AddSpace(title, categories.misc)
ModConfigMenu.AddTitle(title, categories.misc, 'Difficulty')
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.display end,
        Display = function() return 'Display: ' .. (CoopHUDplus.config.misc.difficulty.display and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.misc.difficulty.display = b end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.misc.difficulty.pos.X end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.pos.X = n
            CoopHUDplus.config.misc.greed_machine.pos.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.misc.difficulty.pos.Y end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.pos.Y = n
            CoopHUDplus.config.misc.greed_machine.pos.Y = n
        end,
    }
)

ModConfigMenu.AddText(title, categories.misc, 'Greed')
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.greed_wave_offset.X end,
        Display = function() return 'Text Offset (X): ' .. CoopHUDplus.config.misc.difficulty.greed_wave_offset.X end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.greed_wave_offset.X = n
            CoopHUDplus.config.misc.greed_machine.text_offset.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.misc,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.misc.difficulty.greed_wave_offset.Y end,
        Display = function() return 'Text Offset (Y): ' .. CoopHUDplus.config.misc.difficulty.greed_wave_offset.Y end,
        OnChange = function(n)
            CoopHUDplus.config.misc.difficulty.greed_wave_offset.Y = n
            CoopHUDplus.config.misc.greed_machine.text_offset.Y = n
        end,
    }
)


-- Health settings
ModConfigMenu.AddSetting(
    title,
    categories.health,
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function() return CoopHUDplus.config.health.ignore_curse end,
        Display = function() return 'Ignore Curse of the Unknown: ' .. (CoopHUDplus.config.health.ignore_curse and 'on' or 'off') end,
        OnChange = function(b) CoopHUDplus.config.health.ignore_curse = b end,
    }
)
ModConfigMenu.AddSpace(title, categories.health)
ModConfigMenu.AddSetting(
    title,
    categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.pos.X end,
        Display = function() return 'Pos (X): ' .. CoopHUDplus.config.health.pos.X end,
        OnChange = function(n)
            CoopHUDplus.config.health.pos.X = n
        end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.pos.Y end,
        Display = function() return 'Pos (Y): ' .. CoopHUDplus.config.health.pos.Y end,
        OnChange = function(n)
            CoopHUDplus.config.health.pos.Y = n
        end,
    }
)
ModConfigMenu.AddSpace(title, categories.health)
ModConfigMenu.AddSetting(
    title,
    categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.hearts_per_row end,
        Display = function() return 'Hearts per row: ' .. CoopHUDplus.config.health.hearts_per_row end,
        OnChange = function(n)
            CoopHUDplus.config.health.hearts_per_row = n
        end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.space_between_hearts end,
        Display = function() return 'Offset (X): ' .. CoopHUDplus.config.health.space_between_hearts end,
        OnChange = function(n)
            CoopHUDplus.config.health.space_between_hearts = n
        end,
    }
)
ModConfigMenu.AddSetting(
    title,
    categories.health,
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function() return CoopHUDplus.config.health.space_between_rows end,
        Display = function() return 'Offset (Y): ' .. CoopHUDplus.config.health.space_between_rows end,
        OnChange = function(n)
            CoopHUDplus.config.health.space_between_rows = n
        end,
    }
)
