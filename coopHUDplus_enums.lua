CoopHUDplus.PATHS = {
    ANIMATIONS = {
        active_item = 'gfx/ui/items_coop.anm2', -- taken from coopHUD (Srokks), edited
        chargebar = 'gfx/ui/ui_chargebar.anm2',
        book = 'gfx/005.100_collectible.anm2',
        trinket = 'gfx/005.100_collectible.anm2',
        item = 'gfx/005.100_collectible.anm2',
        pocket_items = 'gfx/ui/coopHUDplus_cards_pills.anm2', -- custom made
        hearts = 'gfx/ui/ui_hearts.anm2',
        hearts_copy = 'gfx/ui/ui_hearts_copy.anm2', -- duplicate of default
        stats = 'gfx/ui/coopHUDplus_hudstats2.anm2', -- custom, edited from default
        misc = 'gfx/ui/coopHUDplus_hudpickups.anm2', -- custom, edited from default
        inv = 'gfx/ui/coopHUDplus_inventory.anm2', -- custom, edited from default
        crafting = 'gfx/ui/coopHUDplus_crafting.anm2', -- custom, edited from default
        poops = 'gfx/ui/ui_poops.anm2',
        streak = 'gfx/ui/ui_streak.anm2',
    },
    FONTS = {
        streak = 'font/upheaval.fnt',
    },
    IMAGES = {
        d_infinity = 'gfx/characters/costumes/costume_489_dinfinity.png',
        virtues_belial = 'gfx/ui/hud_bookofvirtueswithbelial.png',
        virtues = 'gfx/ui/hud_bookofvirtues.png',
        belial = 'gfx/ui/hud_bookofbelial.png',
        jar = 'gfx/characters/costumes/costume_rebirth_90_thejar.png',
        jar_of_flies = 'gfx/characters/costumes/costume_434_jarofflies.png',
        jar_of_wisps = 'gfx/ui/hud_jarofwisps.png',
        everything_jar = 'gfx/ui/hud_everythingjar.png',
        flip = 'gfx/ui/ui_flip_coop.png', -- taken from coopHUD (Srokks)
        mama_mega = 'gfx/ui/hud_mamamega.png',
        smelter = 'gfx/ui/hud_smelter.png',
        glowing_hour_glass = 'gfx/ui/hud_glowinghourglass.png',
        urn_of_souls = 'gfx/ui/hud_urnofsouls.png'
    }
}

CoopHUDplus.PILL = {
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

CoopHUDplus.ActiveItem.D_INFINITY = {
    D1 = 0,
    D4 = 65536,
    D6 = 131072,
    E6 = 196608,
    D7 = 262144,
    D8 = 327680,
    D10 = 393216,
    D12 = 458752,
    D20 = 524288,
    D100 = 589824,
}

CoopHUDplus.Trinket.SLOT_PRIMARY = 0
CoopHUDplus.Trinket.SLOT_SECONDARY = 1

CoopHUDplus.PocketItem.SLOT_PRIMARY = 0
CoopHUDplus.PocketItem.SLOT_SECONDARY = 1
CoopHUDplus.PocketItem.SLOT_TERTIARY = 2
CoopHUDplus.PocketItem.SLOT_QUATERNARY = 3

CoopHUDplus.PocketItem.TYPE_NONE = 0
CoopHUDplus.PocketItem.TYPE_CARD = 1
CoopHUDplus.PocketItem.TYPE_PILL = 2
CoopHUDplus.PocketItem.TYPE_ACTIVE = 3

CoopHUDplus.Stat.SPEED = 0
CoopHUDplus.Stat.FIRE_DELAY = 1
CoopHUDplus.Stat.DAMAGE = 2
CoopHUDplus.Stat.RANGE = 3
CoopHUDplus.Stat.SHOT_SPEED = 4
CoopHUDplus.Stat.LUCK = 5
CoopHUDplus.Stat.DEVIL = 6
CoopHUDplus.Stat.ANGEL = 7
CoopHUDplus.Stat.PLANETARIUM = 8
CoopHUDplus.Stat.DUALITY = 10

CoopHUDplus.Misc.COIN = 0
CoopHUDplus.Misc.KEY = 1
CoopHUDplus.Misc.BOMB = 2
CoopHUDplus.Misc.GOLDEN_KEY = 3
CoopHUDplus.Misc.HARD = 4
CoopHUDplus.Misc.NO_ACHIEVEMENTS = 5
CoopHUDplus.Misc.GOLDEN_BOMB = 6
CoopHUDplus.Misc.GREED = 7
CoopHUDplus.Misc.GREED_MACHINE = 9
CoopHUDplus.Misc.GREEDIER = 11
CoopHUDplus.Misc.SOUL_HEART = 12
CoopHUDplus.Misc.BLACK_HEART = 13
CoopHUDplus.Misc.GIGA_BOMB = 14
CoopHUDplus.Misc.RED_HEART = 15
CoopHUDplus.Misc.POOP = 16

CoopHUDplus.Player.COLORS = {
    [1] = {0.8, 0.9, 1.8, 0.25},
    [2] = {1, 0.2, 0.2, 0.25},
    [3] = {0.2, 1, 0.2, 0.25},
    [4] = {1, 1, 0, 0.25},
}

CoopHUDplus.Callbacks = {
    POST_PLAYER_RENDER = 1,
    PRE_HEALTH_RENDER = 2,
}
