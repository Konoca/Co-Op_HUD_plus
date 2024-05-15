if ModConfigMenu == nil then return end
-- https://github.com/Zamiell/isaac-mod-config-menu/tree/main

CoopHUDplus.MCM = {}
CoopHUDplus.MCM.title = 'Co-Op HUD+'
CoopHUDplus.MCM.categories = {
    general = 'General',
    mods = 'Mods',
    misc = 'Misc.',
    health = 'Health',
    stats = 'Stats',
    items = 'Items',
    active_item = 'Active Items',
    pocket = 'Pocket Items',
    trinket = 'Trinket',
    inventory = 'Inventory',
    streak = 'Streak',
}

local dir = 'coopHUDplus_mcm/'
require(dir..'general')
require(dir..'mods')
require(dir..'stats')
require(dir..'item')
require(dir..'misc')
require(dir..'health')
require(dir..'active_item')
require(dir..'pocket')
require(dir..'trinket')
require(dir..'inventory')
require(dir..'streak')
