CoopHUDplus = RegisterMod('Co-Op HUD+', 1)
CoopHUDplus.version = 0.80

require('scripts.inits')
require('scripts.enums')
require('scripts.config.main')
require('scripts.config.mcm.main')

require('scripts.utils')

require('scripts.HUD.player.stats')
require('scripts.HUD.player.health')
require('scripts.HUD.player.item')
require('scripts.HUD.player.inventory')
require('scripts.HUD.player.main')
require('scripts.HUD.misc')
require('scripts.HUD.main')

require('scripts.commands')
require('scripts.callbacks')
require('scripts.compatabilities.main')

print('Co-Op HUD+ loaded v'..CoopHUDplus.version)
