Better_Coop_HUD.PATHS = {
    ANIMATIONS = {
        active_item = 'gfx/ui/items_coop.anm2', -- animation file taken from coopHUD, credit to Srokks. I custom made the book border
        chargebar = 'gfx/ui/ui_chargebar.anm2',
        book = 'gfx/005.100_collectible.anm2',
        trinket = 'gfx/005.100_collectible.anm2',
        item = 'gfx/005.100_collectible.anm2',
        pocket_items = 'gfx/ui/bch_cards_pills.anm2', -- custom made
        hearts = 'gfx/ui/ui_hearts.anm2',
        stats = 'gfx/ui/bch_hudstats2.anm2', -- custom, edited from default
        misc = 'gfx/ui/bch_hudpickups.anm2', -- custom, edited from default
        inv = 'gfx/ui/bch_inventory.anm2', -- custom, edited from default
        crafting = 'gfx/ui/bch_crafting.anm2', -- custom, edited from default
    },
}

Better_Coop_HUD.PILL = {
    [PillEffect.PILLEFFECT_NULL] = '???',
    [PillEffect.PILLEFFECT_BAD_GAS] = 'Bad Gas',
    [PillEffect.PILLEFFECT_BAD_TRIP] = 'Bad Trip',
    [PillEffect.PILLEFFECT_BALLS_OF_STEEL] = 'Balls of Steel',
    [PillEffect.PILLEFFECT_BOMBS_ARE_KEYS] = 'Bombs are Key',
    [PillEffect.PILLEFFECT_EXPLOSIVE_DIARRHEA] = 'Explosive Diarrhea',
    [PillEffect.PILLEFFECT_FULL_HEALTH] = 'Full Health',
    [PillEffect.PILLEFFECT_HEALTH_DOWN] = 'Health Down',
    [PillEffect.PILLEFFECT_HEALTH_UP] = 'Health Up',
    [PillEffect.PILLEFFECT_I_FOUND_PILLS] = 'I Found Pills',
    [PillEffect.PILLEFFECT_PUBERTY] = 'Puberty',
    [PillEffect.PILLEFFECT_PRETTY_FLY] = 'Pretty Fly',
    [PillEffect.PILLEFFECT_RANGE_DOWN] = 'Range Down',
    [PillEffect.PILLEFFECT_RANGE_UP] = 'Range Up',
    [PillEffect.PILLEFFECT_SPEED_DOWN] = 'Speed Down',
    [PillEffect.PILLEFFECT_SPEED_UP] = 'Speed Up',
    [PillEffect.PILLEFFECT_TEARS_DOWN] = 'Tears Down',
    [PillEffect.PILLEFFECT_TEARS_UP] = 'Tears Up',
    [PillEffect.PILLEFFECT_LUCK_DOWN] = 'Luck Down',
    [PillEffect.PILLEFFECT_LUCK_UP] = 'Luck Up',
    [PillEffect.PILLEFFECT_TELEPILLS] = 'Telepills',
    [PillEffect.PILLEFFECT_48HOUR_ENERGY] = '48 Hour Energy',
    [PillEffect.PILLEFFECT_HEMATEMESIS] = 'Hematemesis',
    [PillEffect.PILLEFFECT_PARALYSIS] = 'Paralysis',
    [PillEffect.PILLEFFECT_SEE_FOREVER] = 'I can See Forever!',
    [PillEffect.PILLEFFECT_PHEROMONES] = 'Pheromones',
    [PillEffect.PILLEFFECT_AMNESIA] = 'Amnesia',
    [PillEffect.PILLEFFECT_LEMON_PARTY] = 'Lemon Party',
    [PillEffect.PILLEFFECT_WIZARD] = 'R U A Wizard?',
    [PillEffect.PILLEFFECT_PERCS] = 'Percs!',
    [PillEffect.PILLEFFECT_ADDICTED] = 'Addicted!',
    [PillEffect.PILLEFFECT_RELAX] = 'Re-Lax!',
    [PillEffect.PILLEFFECT_QUESTIONMARK] = '???',
    [PillEffect.PILLEFFECT_LARGER] = 'One makes you larger',
    [PillEffect.PILLEFFECT_SMALLER] = 'One makes you small',
    [PillEffect.PILLEFFECT_INFESTED_EXCLAMATION] = 'Infested!',
    [PillEffect.PILLEFFECT_INFESTED_QUESTION] = 'Infested?',
    [PillEffect.PILLEFFECT_POWER] = 'Power Pill!',
    [PillEffect.PILLEFFECT_RETRO_VISION] = 'Retro Vision',
    [PillEffect.PILLEFFECT_FRIENDS_TILL_THE_END] = 'Friends Til The End!',
    [PillEffect.PILLEFFECT_X_LAX] = 'X-Lax',
    [PillEffect.PILLEFFECT_SOMETHINGS_WRONG] = 'Something\'s wrong...',
    [PillEffect.PILLEFFECT_IM_DROWSY] = 'I\'m Drowsy...',
    [PillEffect.PILLEFFECT_IM_EXCITED] = 'I\'m Excited!!!',
    [PillEffect.PILLEFFECT_GULP] = 'Gulp!',
    [PillEffect.PILLEFFECT_HORF] = 'Horf!',
    [PillEffect.PILLEFFECT_SUNSHINE] = 'Feels like I\'m walking on sunshine!',
    [PillEffect.PILLEFFECT_VURP] = 'Vurp!',
    [PillEffect.PILLEFFECT_SHOT_SPEED_DOWN] = 'Shot Speed Down',
    [PillEffect.PILLEFFECT_SHOT_SPEED_UP] = 'Shot Speed Up',
    [PillEffect.PILLEFFECT_EXPERIMENTAL] = 'Experimental Pill',
}

Better_Coop_HUD.Trinket.SLOT_PRIMARY = 0
Better_Coop_HUD.Trinket.SLOT_SECONDARY = 1

Better_Coop_HUD.PocketItem.SLOT_PRIMARY = 0
Better_Coop_HUD.PocketItem.SLOT_SECONDARY = 1
Better_Coop_HUD.PocketItem.SLOT_TERTIARY = 2
Better_Coop_HUD.PocketItem.SLOT_QUATERNARY = 3

Better_Coop_HUD.PocketItem.TYPE_NONE = 0
Better_Coop_HUD.PocketItem.TYPE_CARD = 1
Better_Coop_HUD.PocketItem.TYPE_PILL = 2
Better_Coop_HUD.PocketItem.TYPE_ACTIVE = 3

Better_Coop_HUD.Stat.SPEED = 0
Better_Coop_HUD.Stat.FIRE_DELAY = 1
Better_Coop_HUD.Stat.DAMAGE = 2
Better_Coop_HUD.Stat.RANGE = 3
Better_Coop_HUD.Stat.SHOT_SPEED = 4
Better_Coop_HUD.Stat.LUCK = 5
Better_Coop_HUD.Stat.DEVIL = 6
Better_Coop_HUD.Stat.ANGEL = 7
Better_Coop_HUD.Stat.PLANETARIUM = 8
Better_Coop_HUD.Stat.DUALITY = 10

Better_Coop_HUD.Misc.COIN = 0
Better_Coop_HUD.Misc.KEY = 1
Better_Coop_HUD.Misc.BOMB = 2
Better_Coop_HUD.Misc.GOLDEN_KEY = 3
Better_Coop_HUD.Misc.HARD = 4
Better_Coop_HUD.Misc.NO_ACHIEVEMENTS = 5
Better_Coop_HUD.Misc.GOLDEN_BOMB = 6
Better_Coop_HUD.Misc.GREED = 7
Better_Coop_HUD.Misc.GREED_MACHINE = 8
Better_Coop_HUD.Misc.GREEDIER = 11
Better_Coop_HUD.Misc.SOUL_HEART = 12
Better_Coop_HUD.Misc.BLACK_HEART = 13
Better_Coop_HUD.Misc.GIGA_BOMB = 14
Better_Coop_HUD.Misc.RED_HEART = 15
Better_Coop_HUD.Misc.POOP = 16

Better_Coop_HUD.Inventory.RED_HEART = 1
Better_Coop_HUD.Inventory.SOUL_HEART = 2
Better_Coop_HUD.Inventory.ETERNAL_HEART = 3
Better_Coop_HUD.Inventory.BLACK_HEART = 4
Better_Coop_HUD.Inventory.GOLD_HEART = 5
Better_Coop_HUD.Inventory.BONE_HEART = 6
Better_Coop_HUD.Inventory.ROTTEN_HEART = 7

Better_Coop_HUD.Inventory.PENNY = 8
Better_Coop_HUD.Inventory.NICKEL = 9
Better_Coop_HUD.Inventory.DIME = 10
Better_Coop_HUD.Inventory.LUCKY_PENNY = 11

Better_Coop_HUD.Inventory.KEY = 12
Better_Coop_HUD.Inventory.GOLDEN_KEY = 13
Better_Coop_HUD.Inventory.CHARGED_KEY = 14

Better_Coop_HUD.Inventory.BOMB = 15
Better_Coop_HUD.Inventory.GOLDEN_BOMB = 16
Better_Coop_HUD.Inventory.GIGA_BOMB = 17

Better_Coop_HUD.Inventory.MICRO_BATTERY = 18
Better_Coop_HUD.Inventory.LIL_BATTERY = 19
Better_Coop_HUD.Inventory.MEGA_BATTERY = 20

Better_Coop_HUD.Inventory.CARD = 21
Better_Coop_HUD.Inventory.PILL = 22
Better_Coop_HUD.Inventory.RUNE = 23

Better_Coop_HUD.Inventory.DICE_SHARD = 24
Better_Coop_HUD.Inventory.CRACKED_KEY = 25

Better_Coop_HUD.Inventory.GOLDEN_PENNY = 26
Better_Coop_HUD.Inventory.GOLDEN_PILL = 27
Better_Coop_HUD.Inventory.GOLDEN_BATTERY = 28

Better_Coop_HUD.Inventory.POOP = 29
