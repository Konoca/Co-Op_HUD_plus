Better_Coop_HUD.config = {
    disable = false,

    offset = Vector(20, 20),
    mirrored_extra_offset = Vector(60, 0),

    twin_pos = Vector(0, 40), -- on-top-of
    -- twin_pos = Vector(110, 0), -- side-by-side

    enable_toggle_hud = true,

    active_item = {
        book_correction_offset = Vector(0, -5),
        book_charge_outline = true,
        [0] = {
            pos = Vector(0, 8),
            chargebar = {
                pos = Vector(18, 9),
                stay_on_right = false,
                display = true,
            },
            scale = Vector(1, 1),
        },
        [1] = {
            -- pos = Vector(-15, 25),
            pos = Vector(-15, -6),
            chargebar = {
                pos = Vector(-6, 26),
                stay_on_right = false,
                display = false,
            },
            scale = Vector(0.4, 0.4),
        },
    },

    trinket = {
        [0] = {
            pos = Vector(105, 10),
            scale = Vector(0.5, 0.5),
        },
        [1] = {
            pos = Vector(105, 20),
            scale = Vector(0.5, 0.5),
        },
    },

    pocket = {
        -- [0] = {
        --    pos = Vector(117, 0),
        --    scale = Vector(0.5, 0.5),
        -- },
        -- [1] = {
        --    pos = Vector(117, 10),
        --    scale = Vector(0.5, 0.5),
        -- },
        -- [2] = {
        --    pos = Vector(129, 0),
        --    scale = Vector(0.5, 0.5),
        -- },
        -- [3] = {
        --    pos = Vector(129, 10),
        --    scale = Vector(0.5, 0.5),
        -- },
        -- TODO line up item with hearts
        [0] = {
            pos = Vector(30, 25),
            scale = Vector(0.5, 0.5),
        },
        [1] = {
            pos = Vector(20, 25),
            scale = Vector(0.5, 0.5),
        },
        [2] = {
            pos = Vector(10, 25),
            scale = Vector(0.5, 0.5),
        },
        [3] = {
            pos = Vector(0, 25),
            scale = Vector(0.5, 0.5),
        },
        text = {
            display = true,
            pos = Vector(40, 19),
            scale = Vector(1, 1),
        },
    },

    health = {
        hearts_per_row = 6,
        space_between_hearts = 12,
        space_between_rows = 12,
        pos = Vector(28, 0),
        ignore_curse = false,
    },

    stats = {
        pos = Vector(0, 90),
        offset = Vector(0, 12),

        scale = Vector(1, 1),
        mirrored_offset = Vector(60, 0),

        text = {
            pos = Vector(10, 84),
            offset = Vector(0, 12),
            mirrored_offset = Vector(45, 0),
            scale = Vector(0.5, 0.5),

            twin_offset = Vector(20, 0)
        }
    },

    misc = {
        pickups = {
            pos = Vector(0, 137),
            scale = Vector(1, 1),
            offset = Vector(25, 0),
            center_anchor = true,
        },
        difficulty = {
            pos = Vector(0, 75),
            scale = Vector(1, 1),
            display = true,
        },
        greed_machine = {
            pos = Vector(0, 0),
            scale = Vector(1, 1),
        },
        text = {
            offset = Vector(6, -6),
            scale = Vector(1, 1),
        }
    },

    mods = {
        mAPI = {
            pos = Vector(4, 4),
            frame = Vector(55, 55),
        },
        EID = {
            XPosition = 135,
            YPosition = 0,
            DisplayMode = 'local',
            HUDOffset = 10,
            enable = true,
        },
    },
}
