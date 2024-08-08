CoopHUDplus = RegisterMod('Co-Op HUD+', 1)
CoopHUDplus.version = 0.80


require('scripts.inits')
require('scripts.enums')
require('scripts.config.main')
require('scripts.config.mcm.main')

require('scripts.utils')

-- require('coopHUDplus_objs.stat')
-- require('coopHUDplus_objs.heart')
-- require('coopHUDplus_objs.item')
-- require('coopHUDplus_objs.misc')
-- require('coopHUDplus_objs.inventory')
-- require('coopHUDplus_objs.player')
-- require('coopHUDplus_objs.hud')

require('scripts.HUD.player.health')
require('scripts.HUD.player.main')
require('scripts.HUD.main')

require('scripts.commands')
-- require('coopHUDplus_callbacks')
-- require('scripts.compatabilities.main')

print('Co-Op HUD+ loaded v'..CoopHUDplus.version)
