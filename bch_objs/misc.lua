function Better_Coop_HUD.Misc.new(value, frame)
    local self = setmetatable({}, Better_Coop_HUD.Misc)

    self.value = value
    self.frame = frame

    self.sprite = self:getSprite()

    return self
end

function Better_Coop_HUD.Misc:getSprite()
    if not self.frame then return nil end
    local sprite = Sprite()

    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.misc, true)
    sprite:SetFrame('Idle', self.frame)

    return sprite
end

function Better_Coop_HUD.Misc:render(pos, scale, text_format)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite:Render(pos)

    if self.value and text_format then
        -- TODO handle case when player can have more than 99 items
        local text_pos = pos + Better_Coop_HUD.config.misc.text.offset
        Isaac.RenderScaledText(
            string.format(text_format, self.value),
            text_pos.X, text_pos.Y,
            Better_Coop_HUD.config.misc.text.scale.X,
            Better_Coop_HUD.config.misc.text.scale.Y,
            1, 1, 1, 1
        )
    end
end

function Better_Coop_HUD.Miscs.new()
    local self = setmetatable({}, Better_Coop_HUD.Miscs)

    -- TODO have this not print an error to console
    if not Better_Coop_HUD.players[0] then return self end
    local player_entity = Better_Coop_HUD.players[0].player_entity

    -- pickups
    self.coins = Better_Coop_HUD.Misc.new(player_entity:GetNumCoins(), Better_Coop_HUD.Misc.COIN)

    local key_sprite = Better_Coop_HUD.Misc.KEY
    if player_entity:HasGoldenKey() then
        key_sprite = Better_Coop_HUD.Misc.GOLDEN_KEY
    end
    self.keys = Better_Coop_HUD.Misc.new(player_entity:GetNumKeys(), key_sprite)

    local bomb_sprite = Better_Coop_HUD.Misc.BOMB
    if player_entity:GetNumGigaBombs() > 0 then
        bomb_sprite = Better_Coop_HUD.Misc.GIGA_BOMB
    end
    if player_entity:HasGoldenBomb() then
        bomb_sprite = Better_Coop_HUD.Misc.GOLDEN_BOMB
    end
    self.bombs = Better_Coop_HUD.Misc.new(player_entity:GetNumBombs(), bomb_sprite)

    self.poop = Better_Coop_HUD.Misc.new(player_entity:GetPoopMana(), Better_Coop_HUD.Misc.POOP)

    self.soul_charge = Better_Coop_HUD.Misc.new(player_entity:GetSoulCharge(), Better_Coop_HUD.Misc.SOUL_HEART)
    self.blood_charge = Better_Coop_HUD.Misc.new(player_entity:GetBloodCharge(), Better_Coop_HUD.Misc.RED_HEART)

    -- indicators
    local gameDiff = Game().Difficulty
    local diffMap = {
        [Difficulty.DIFFICULTY_NORMAL] = nil,
        [Difficulty.DIFFICULTY_HARD] = Better_Coop_HUD.Misc.HARD,
        [Difficulty.DIFFICULTY_GREED] = nil,
        [Difficulty.DIFFICULTY_GREEDIER] = Better_Coop_HUD.Misc.GREEDIER,
    }
    self.difficulty = Better_Coop_HUD.Misc.new(nil, diffMap[gameDiff])

    -- greed donation machine jam percentage
    if Game():IsGreedMode() then
        self.jam_perc = Better_Coop_HUD.Misc.new(
            player_entity:GetGreedDonationBreakChange(),
            Better_Coop_HUD.Misc.GREED_MACHINE
        )
    end

    self.display_bombs = false
    self.display_poop = false

    self.display_soul_charge = false
    self.display_blood_charge = false

    for i = 0, #Better_Coop_HUD.players, 1 do
        local p = Better_Coop_HUD.players[i]
        local p_type = p.player_entity:GetPlayerType()
        if p_type == PlayerType.PLAYER_XXX_B then self.display_poop = true end
        if p_type ~= PlayerType.PLAYER_XXX_B then self.display_bombs = true end
        if p_type == PlayerType.PLAYER_BETHANY then self.display_soul_charge = true end
        if p_type == PlayerType.PLAYER_BETHANY_B then self.display_blood_charge = true end
    end

    return self
end

function Better_Coop_HUD.Miscs:render(screen_center)
    if not Better_Coop_HUD.players[0] then return end

    local offset = Better_Coop_HUD.config.misc.pickups.offset
    local pos = Better_Coop_HUD.config.misc.pickups.pos
    if Better_Coop_HUD.config.misc.pickups.center_anchor then pos = pos + screen_center end
    local scale = Better_Coop_HUD.config.misc.pickups.scale

    local map = {
        {self.coins, true},
        {self.keys, true},
        {self.bombs, self.display_bombs},
        {self.poop, self.display_poop},
        {self.soul_charge, self.display_soul_charge},
        {self.blood_charge, self.display_blood_charge},
    }

    local total = 0
    for i = 1, #map, 1 do
        if map[i][2] then total = total + 1 end
    end

    pos = pos - (offset * (total / 2))

    for i = 1, #map, 1 do
        if map[i][2] then
            map[i][1]:render(pos, scale, '%02d')
            pos = pos + offset
        end
    end

    if Better_Coop_HUD.config.misc.difficulty.display then
        pos = Better_Coop_HUD.config.misc.difficulty.pos + Better_Coop_HUD.config.offset
        scale = Better_Coop_HUD.config.misc.difficulty.scale
        self.difficulty:render(pos, scale, nil)
    end

    if self.jam_perc then
        pos = Better_Coop_HUD.config.misc.greed_machine.pos
        scale = Better_Coop_HUD.config.misc.greed_machine.scale
        self.jam_perc:render(pos, scale, '%d%%')
    end

end
