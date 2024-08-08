function CoopHUDplus.ResetConfig() CoopHUDplus.config = {
    disable = false,
    version = CoopHUDplus.version,

    offset = Vector(20, 20),
    mirrored_extra_offset = Vector(60, 0),

    twin_pos = Vector(0, 40), -- on-top-of
    -- twin_pos = Vector(110, 0), -- side-by-side

    enable_toggle_hud = true,

    player_colors = false,
    display_during_pause = true,

    items = {
        display = true,
        pos = Vector(-10, 195),
        anchors = Vector(1, 0),
        offset = Vector(0, 10),
        player_offset = Vector(-10, 0),
        scale = Vector(0.4, 0.4),
        items_per_player = 6,
        colors = true,
    },

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
        [0] = {
            pos = Vector(28, 25),
            scale = Vector(0.5, 0.5),
        },
        [1] = {
            pos = Vector(18, 25),
            scale = Vector(0.5, 0.5),
        },
        [2] = {
            pos = Vector(8, 25),
            scale = Vector(0.5, 0.5),
        },
        [3] = {
            pos = Vector(0, 25),
            scale = Vector(0.25, 0.25),
        },
        text = {
            display = true,
            pos = Vector(40, 21),
            scale = Vector(0.5, 0.5),
        },
        chargebar = {
            display = true,
            stay_on_right = false,
            pos = Vector(8, 1),
            scale = Vector(0.5, 0.5)
        }
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
            lowered_offset = Vector(6, 6),
            scale = Vector(0.5, 0.5),

            twin_offset = Vector(20, 0),
            colors = true,
        }
    },

    misc = {
        pickups = {
            pos = Vector(0, -10),
            scale = Vector(1, 1),
            offset = Vector(25, 0),
            center_anchor = true,
            bottom_anchor = true,
        },
        difficulty = {
            pos = Vector(0, 75),
            scale = Vector(1, 1),
            display = true,
            greed_wave_offset = Vector(4, -1),
        },
        greed_machine = {
            pos = Vector(0, 75),
            scale = Vector(1, 1),
            text_offset = Vector(4, -1),
        },
        text = {
            offset = Vector(6, -6),
            scale = Vector(1, 1),
        }
    },

    inventory = {
        pos = Vector(0, 40),
        spacing = Vector(12, 12),
        ignore_curse = false,
        result_pos = Vector(65, 46)
    },

    streak = {
        pos = Vector(0, 50),
        center_anchor = true,
        bottom_anchor = false,
        name = {
            offset = Vector(0, -10),
            scale = Vector(1, 1),
            box_width = 10,
            box_center = true,
        },
        description = {
            offset = Vector(0, 10),
            scale = Vector(0.5, 0.5),
            box_width = 10,
            box_center = true,
        },
        curse = {
            offset = Vector(0, 21),
            scale = Vector(0.5, 0.5),
            box_width = 10,
            box_center = true,
        }
    },

    fonts = {
        streaks = 'upheaval',
        timer = 'terminus8',
        pickups = 'terminus8',
        -- stats = 'luaminioutlined',
        stats = 'terminus8',
        pocket_items = 'terminus8',
        extra_lives = 'terminus8',
    },

    mods = {
        mAPI = {
            pos = Vector(4, 4),
            frame = Vector(55, 55),
            override = true,
        },
        -- EID = {
        --     XPosition = 135,
        --     YPosition = 5,
        --     DisplayMode = 'local',
        --     HUDOffset = 10,
        --     enable = true,
        --     override = false,
        -- },
        EPIPHANY = {
            hud_element_pos = Vector(50, 42),
        }
    },
}
end

CoopHUDplus.ResetConfig()
