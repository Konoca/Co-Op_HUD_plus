CoopHUDplus = RegisterMod('Co-Op HUD+', 1)
local version = '0.5 DEV'

require('coopHUDplus_objs/inits')
require('coopHUDplus_enums')
require('coopHUDplus_config')
require('coopHUDplus_mcm/mcm')

require('coopHUDplus_objs/stat')
require('coopHUDplus_objs/heart')
require('coopHUDplus_objs/item')
require('coopHUDplus_objs/misc')
require('coopHUDplus_objs/inventory')
require('coopHUDplus_objs/player')
require('coopHUDplus_objs/hud')

require('coopHUDplus_commands')

require('coopHUDplus_callbacks')

print('Co-Op HUD+ loaded v'..version)
