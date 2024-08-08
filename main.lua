Better_Coop_HUD = RegisterMod('Better Coop HUD', 1)
local version = '1.0'

require('bch_objs/inits')
require('bch_enums')
require('bch_config')
require('bch_mcm')

require('bch_objs/stat')
require('bch_objs/heart')
require('bch_objs/item')
require('bch_objs/misc')
require('bch_objs/player')
require('bch_objs/hud')

require('bch_callbacks')

print('Better Coop HUD loaded v'..version)
