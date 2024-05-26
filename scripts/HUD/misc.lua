local mod = CoopHUDplus
local Misc = mod.Misc

local DATA = mod.DATA

local game = Game()

local sprite = Sprite()
sprite:Load(mod.PATHS.ANIMATIONS.misc, true)
sprite:SetFrame('Idle', 0)


function Misc.GetMisc(value, frame)
    return {
        Value = value,
        Frame = frame,
        Anim = mod.PATHS.ANIMATIONS.misc
    }
end

function Misc.GetPickups(player_entity)
    local pickups = {}
    pickups[1] = Misc.GetMisc(player_entity:GetNumCoins(), Misc.COIN)

    local bomb_sprite = Misc.BOMB
    if player_entity:HasGoldenBomb() then
        bomb_sprite = Misc.GOLDEN_BOMB
    end
    if player_entity:GetNumGigaBombs() > 0 then
        bomb_sprite = Misc.GIGA_BOMB
    end
    pickups[2] = Misc.GetMisc(player_entity:GetNumBombs(), bomb_sprite)
    pickups[3] = Misc.GetMisc(player_entity:GetPoopMana(), Misc.POOP)

    local key_sprite = Misc.KEY
    if player_entity:HasGoldenKey() then
        key_sprite = Misc.GOLDEN_KEY
    end
    pickups[4] = Misc.GetMisc(player_entity:GetNumKeys(), key_sprite)

    pickups[5] = Misc.GetMisc(player_entity:GetSoulCharge(), Misc.SOUL_HEART)
    pickups[6] = Misc.GetMisc(player_entity:GetBloodCharge(), Misc.RED_HEART)

    return pickups
end

function Misc.FilterPickups()
    local display = {
        [1] = true,
        [4] = true,
    }

    for i = 1, #DATA.PLAYERS, 1 do
        local pType = DATA.PLAYERS[i].PlayerType
        if pType == PlayerType.PLAYER_XXX_B then display[3] = true end
        if pType ~= PlayerType.PLAYER_XXX_B then display[2] = true end
        if pType == PlayerType.PLAYER_BETHANY then display[5] = true end
        if pType == PlayerType.PLAYER_BETHANY_B then display[6] = true end
    end

    return display
end

function Misc.GetDifficulty(level, stage)
    local gameDiff = game.Difficulty
    local diffMap = {
        [Difficulty.DIFFICULTY_NORMAL] = nil,
        [Difficulty.DIFFICULTY_HARD] = Misc.HARD,
        [Difficulty.DIFFICULTY_GREED] = Misc.GREED,
        [Difficulty.DIFFICULTY_GREEDIER] = Misc.GREEDIER,
    }

    local str = nil
    if game:IsGreedMode() and stage ~= LevelStage.STAGE7_GREED then
        local maxWaves = game:GetGreedWavesNum() - 1
        local currWave = level.GreedModeWave
        str = string.format('%d/%d', currWave, maxWaves)
    end

    return Misc.GetMisc(str, diffMap[gameDiff])
end

function Misc.GetGreedJam(player_entity, stage)
    if not game:IsGreedMode() or stage ~= LevelStage.STAGE7_GREED then
        return nil
    end
    return Misc.GetMisc(
        player_entity:GetGreedDonationBreakChance(),
        Misc.GREED_MACHINE
    )
end

function Misc.Render(screen_size, screen_center, player_entity)
    local pos = Vector(0, 0)
    if mod.config.misc.pickups.center_anchor then pos = screen_center end
    if mod.config.misc.pickups.bottom_anchor then pos.Y = screen_size.Y end
    pos = pos + mod.config.misc.pickups.pos
    local offset = mod.config.misc.pickups.offset

    local level = game:GetLevel()
    local stage = level:GetStage()

    local pickups = Misc.GetPickups(player_entity)
    local difficulty = Misc.GetDifficulty(level, stage)
    local greedJam = Misc.GetGreedJam(player_entity, stage)

    local map = Misc.FilterPickups()

    mod.Utils.CreateCallback(mod.Callbacks.PRE_MISC_RENDER, pickups, map, difficulty, greedJam)

    local total = 0
    for _, v in pairs(map) do
        if v then total = total + 1 end
    end
    pos = pos - (offset * (total / 2))

    sprite.Scale = mod.config.misc.pickups.scale
    local text_scale = mod.config.misc.text.scale
    for k, v in pairs(pickups) do
        if not map[k] then goto skip_pickup end

        sprite:Load(v.Anim, true)
        sprite:SetFrame('Idle', v.Frame)
        sprite:Render(pos)

        if v.Value then
            local text_pos = pos + mod.config.misc.text.offset
            DATA.FONTS.pickups:DrawStringScaled(
                string.format('%02d', v.Value),
                text_pos.X, text_pos.Y,
                text_scale.X,
                text_scale.Y,
                KColor(1, 1, 1, 1),
                0, true
            )
        end

        pos = pos + offset

        ::skip_pickup::
    end

    if mod.config.misc.difficulty.display then
        pos = mod.config.misc.difficulty.pos + mod.config.offset
        if difficulty.Frame then
            sprite.Scale = mod.config.misc.difficulty.scale
            sprite:SetFrame('Idle', difficulty.Frame)
            sprite:Render(pos)
        end
        if difficulty.Value then
            local text_pos = pos + mod.config.misc.text.offset + mod.config.misc.difficulty.greed_wave_offset
            DATA.FONTS.pickups:DrawStringScaled(
                difficulty.Value,
                text_pos.X, text_pos.Y,
                text_scale.X,
                text_scale.Y,
                KColor(1, 1, 1, 1),
                0, true
            )
        end
    end

    if greedJam then
        pos = mod.config.misc.greed_machine.pos + mod.config.offset
        sprite.Scale = mod.config.misc.greed_machine.scale
        sprite:SetFrame('Idle', greedJam.Frame)
        sprite:Render(pos)

        local text_pos = pos + mod.config.misc.text.offset + mod.config.misc.difficulty.greed_wave_offset
        DATA.FONTS.pickups:DrawStringScaled(
            string.format('%d%%', greedJam.Value),
            text_pos.X, text_pos.Y,
            text_scale.X,
            text_scale.Y,
            KColor(1, 1, 1, 1),
            0, true
        )
    end
end