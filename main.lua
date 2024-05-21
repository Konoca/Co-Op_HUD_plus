CoopHUDplus = RegisterMod('Co-Op HUD+', 1)
CoopHUDplus.version = 0.8


require('coopHUDplus_objs.inits')
require('coopHUDplus_enums')
require('coopHUDplus_config')
require('coopHUDplus_mcm.mcm')

require('coopHUDplus_utils')

require('coopHUDplus_objs.stat')
require('coopHUDplus_objs.heart')
require('coopHUDplus_objs.item')
require('coopHUDplus_objs.misc')
require('coopHUDplus_objs.inventory')
require('coopHUDplus_objs.player')
require('coopHUDplus_objs.hud')

require('coopHUDplus_commands')
require('coopHUDplus_callbacks')
require('coopHUDplus_compatabilities.main')

print('Co-Op HUD+ loaded v'..CoopHUDplus.version)
