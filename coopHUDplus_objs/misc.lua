function CoopHUDplus.Misc.new(value, frame)
    local self = setmetatable({}, CoopHUDplus.Misc)

    self.value = value
    self.frame = frame

    self.sprite = self:getSprite()

    return self
end

function CoopHUDplus.Misc:getSprite()
    if not self.frame then return nil end
    local sprite = Sprite()

    sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.misc, true)
    sprite:SetFrame('Idle', self.frame)

    return sprite
end

function CoopHUDplus.Misc:render(pos, scale, text_format, additional_text_offset)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite:Render(pos)

    if self.value and text_format then
        -- TODO handle case when player can have more than 99 items
        local text_pos = pos + CoopHUDplus.config.misc.text.offset + additional_text_offset
        Isaac.RenderScaledText(
            string.format(text_format, self.value),
            text_pos.X, text_pos.Y,
            CoopHUDplus.config.misc.text.scale.X,
            CoopHUDplus.config.misc.text.scale.Y,
            1, 1, 1, 1
        )
    end
end

function CoopHUDplus.Miscs.new()
    local self = setmetatable({}, CoopHUDplus.Miscs)
    local game = Game()

    if not CoopHUDplus.players[0] then return self end
    local player_entity = CoopHUDplus.players[0].player_entity

    -- pickups
    self.coins = CoopHUDplus.Misc.new(player_entity:GetNumCoins(), CoopHUDplus.Misc.COIN)

    local key_sprite = CoopHUDplus.Misc.KEY
    if player_entity:HasGoldenKey() then
        key_sprite = CoopHUDplus.Misc.GOLDEN_KEY
    end
    self.keys = CoopHUDplus.Misc.new(player_entity:GetNumKeys(), key_sprite)

    local bomb_sprite = CoopHUDplus.Misc.BOMB
    if player_entity:GetNumGigaBombs() > 0 then
        bomb_sprite = CoopHUDplus.Misc.GIGA_BOMB
    end
    if player_entity:HasGoldenBomb() then
        bomb_sprite = CoopHUDplus.Misc.GOLDEN_BOMB
    end
    self.bombs = CoopHUDplus.Misc.new(player_entity:GetNumBombs(), bomb_sprite)

    self.poop = CoopHUDplus.Misc.new(player_entity:GetPoopMana(), CoopHUDplus.Misc.POOP)

    self.soul_charge = CoopHUDplus.Misc.new(player_entity:GetSoulCharge(), CoopHUDplus.Misc.SOUL_HEART)
    self.blood_charge = CoopHUDplus.Misc.new(player_entity:GetBloodCharge(), CoopHUDplus.Misc.RED_HEART)

    -- indicators
    local gameDiff = game.Difficulty
    local diffMap = {
        [Difficulty.DIFFICULTY_NORMAL] = nil,
        [Difficulty.DIFFICULTY_HARD] = CoopHUDplus.Misc.HARD,
        [Difficulty.DIFFICULTY_GREED] = CoopHUDplus.Misc.GREED,
        [Difficulty.DIFFICULTY_GREEDIER] = CoopHUDplus.Misc.GREEDIER,
    }
    self.difficulty = CoopHUDplus.Misc.new(nil, diffMap[gameDiff])

    local level = game:GetLevel()
    local stage = level:GetStage()

    if game:IsGreedMode() and stage ~= LevelStage.STAGE7_GREED then
        local maxWaves = game:GetGreedWavesNum() - 1
        local currWave = level.GreedModeWave
        self.difficulty = CoopHUDplus.Misc.new(string.format('%d/%d', currWave, maxWaves), diffMap[gameDiff])
    end

    -- greed donation machine jam percentage
    if game:IsGreedMode() and stage == LevelStage.STAGE7_GREED then
        self.jam_perc = CoopHUDplus.Misc.new(
            player_entity:GetGreedDonationBreakChance(),
            CoopHUDplus.Misc.GREED_MACHINE
        )
    end

    self.display_bombs = false
    self.display_poop = false

    self.display_soul_charge = false
    self.display_blood_charge = false

    for i = 0, #CoopHUDplus.players, 1 do
        local p = CoopHUDplus.players[i]
        local p_type = p.player_entity:GetPlayerType()
        if p_type == PlayerType.PLAYER_XXX_B then self.display_poop = true end
        if p_type ~= PlayerType.PLAYER_XXX_B then self.display_bombs = true end
        if p_type == PlayerType.PLAYER_BETHANY then self.display_soul_charge = true end
        if p_type == PlayerType.PLAYER_BETHANY_B then self.display_blood_charge = true end
    end

    return self
end

function CoopHUDplus.Miscs:render(screen_size, screen_center)
    if not CoopHUDplus.players[0] then return end

    local pos = Vector(0, 0)
    if CoopHUDplus.config.misc.pickups.center_anchor then pos = screen_center end
    if CoopHUDplus.config.misc.pickups.bottom_anchor then pos.Y = screen_size.Y end
    pos = pos + CoopHUDplus.config.misc.pickups.pos
    local offset = CoopHUDplus.config.misc.pickups.offset
    local scale = CoopHUDplus.config.misc.pickups.scale

    local map = {
        {self.coins, true},
        {self.keys, true},
        {self.bombs, self.display_bombs},
        {self.poop, self.display_poop},
        {self.soul_charge, self.display_soul_charge},
        {self.blood_charge, self.display_blood_charge},
    }

    CoopHUDplus.Utils.CreateCallback(CoopHUDplus.Callbacks.PRE_MISC_RENDER, self, map)

    local total = 0
    for i = 1, #map, 1 do
        if map[i][2] then total = total + 1 end
    end

    pos = pos - (offset * (total / 2))

    for i = 1, #map, 1 do
        if map[i][2] then
            map[i][1]:render(pos, scale, '%02d', Vector(0, 0))
            pos = pos + offset
        end
    end

    if CoopHUDplus.config.misc.difficulty.display then
        pos = CoopHUDplus.config.misc.difficulty.pos + CoopHUDplus.config.offset
        scale = CoopHUDplus.config.misc.difficulty.scale
        self.difficulty:render(pos, scale, '%s', CoopHUDplus.config.misc.difficulty.greed_wave_offset)
    end

    if self.jam_perc then
        pos = CoopHUDplus.config.misc.greed_machine.pos + CoopHUDplus.config.offset
        scale = CoopHUDplus.config.misc.greed_machine.scale
        self.jam_perc:render(pos, scale, '%d%%', CoopHUDplus.config.misc.greed_machine.text_offset)
    end

end
