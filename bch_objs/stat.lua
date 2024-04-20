function Better_Coop_HUD.Stat.new(player_entity, stat, is_percent)
    local self = setmetatable({}, Better_Coop_HUD.Stat)

    self.player_entity = player_entity
    self.stat = stat
    self.is_percent = is_percent

    self.value = self:getValue()
    self.sprite = self:getSprite()

    return self
end

function Better_Coop_HUD.Stat:getValue()
    if self.stat == Better_Coop_HUD.Stat.SPEED then return self.player_entity.MoveSpeed end
    if self.stat == Better_Coop_HUD.Stat.FIRE_DELAY then return 30 / (self.player_entity.MaxFireDelay + 1) end
    if self.stat == Better_Coop_HUD.Stat.DAMAGE then return self.player_entity.Damage end
    if self.stat == Better_Coop_HUD.Stat.RANGE then return self.player_entity.TearRange / 40 end
    if self.stat == Better_Coop_HUD.Stat.SHOT_SPEED then return self.player_entity.ShotSpeed end
    if self.stat == Better_Coop_HUD.Stat.LUCK then return self.player_entity.Luck end

    -- TODO devil chance starts at 135%, angel chance also stored in devil chance. if can be either, need to split devil in half
    if self.stat == Better_Coop_HUD.Stat.DEVIL then return self:getAngelDevilChance().devil * 100 end
    if self.stat == Better_Coop_HUD.Stat.ANGEL then return self:getAngelDevilChance().angel * 100 end
    if self.stat == Better_Coop_HUD.Stat.PLANETARIUM then return Game():GetLevel():GetPlanetariumChance() * 100 end
end

-- TODO this only works for angel modifications, needs to take into account angel/devil only and splits
function Better_Coop_HUD.Stat:getAngelDevilChance()
    local game = Game()
    local level = game:GetLevel()
    local room = game:GetRoom()
    local stage = level:GetStage()

    -- stages where you cant get a deal
    local disallowed_stages = {
        [1] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
    }

    local chances = {
        deal = 0.0,
        angel = 0.0,
        devil = 0.0,
        -- duality = 0.0,
    }

    if disallowed_stages[stage] then return chances end

    chances.deal = room:GetDevilRoomChance()
    chances.deal = chances.deal > 1 and 1 or chances.deal

    chances.angel = 1.0

    local mods = {}

    local collectibles = {
        [CollectibleType.COLLECTIBLE_KEY_PIECE_1] = 0.75,
        [CollectibleType.COLLECTIBLE_KEY_PIECE_2] = 0.75,
        [CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES] = 0.75,
    }

    local trinkets = {
        [TrinketType.TRINKET_ROSARY_BEAD] = 0.5,
    }

    local level_flags = {
        [LevelStateFlag.STATE_BUM_KILLED] = 0.75,
        [LevelStateFlag.STATE_BUM_LEFT] = 0.9,
        [LevelStateFlag.STATE_EVIL_BUM_LEFT] = 1.1,
    }

    -- check items
    -- local duality = false
    local eucharist = false
    for i = 0, game:GetNumPlayers() - 1, 1 do
        local p = Isaac.GetPlayer(i)

        for k, v in pairs(collectibles) do
            if p:HasCollectible(k) then
                table.insert(mods, v)
            end
        end
        for k, v in pairs(trinkets) do
            if p:HasTrinket(k) then
                table.insert(mods, v)
            end
        end

        if p:HasCollectible(CollectibleType.COLLECTIBLE_EUCHARIST) then eucharist = true end
        -- if p:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then duality = true end
    end
    if eucharist then
        -- https://bindingofisaacrebirth.fandom.com/wiki/Eucharist
        chances.devil = 0
        chances.angel = 1
        return chances
    end

    -- check level flags
    for k, v in pairs(level_flags) do
        if level:GetStateFlag(k) then
            table.insert(mods, v)
        end
    end

    -- donation machine
    if game:GetDonationModAngel() >= 10 then
        table.insert(mods, 0.5)
    end

    -- calculation
    if game:GetStateFlag(GameStateFlag.STATE_DEVILROOM_VISITED) then
        chances.angel = 0.5
        for i = 1, #mods, 1 do
            chances.angel = chances.angel * mods[i]
        end
        chances.angel = 1.0 - (chances.angel * (1.0 - level:GetAngelRoomChance()))
    end

    chances.devil = chances.deal * (1.0 - chances.angel)
    chances.angel = chances.deal * chances.angel

    return chances
end

function Better_Coop_HUD.Stat:getSprite()
    local sprite = Sprite()
    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.stats, true)
    sprite:SetFrame('Idle', self.stat)
    return sprite
end


function Better_Coop_HUD.Stat:render(pos_vector, text_pos_vector, render_icon)
    if render_icon then
        self.sprite.Scale = Better_Coop_HUD.config.stats.scale
        self.sprite:Render(pos_vector)
    end

    -- TODO visual difference if stat changed
    Isaac.RenderScaledText(
        string.format(self.is_percent and '%.1f%%' or '%.2f', self.value),
        text_pos_vector.X, text_pos_vector.Y,
        Better_Coop_HUD.config.stats.text.scale.X,
        Better_Coop_HUD.config.stats.text.scale.Y,
        1, 1, 1, 0.5
    )
end

function Better_Coop_HUD.Stats.new(player_entity, player)
    local self = setmetatable({}, Better_Coop_HUD.Stats)

    self.player_entity = player_entity
    self.player = player

    self.speed = Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.SPEED)
    self.fire_delay = Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.FIRE_DELAY)
    self.damage = Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.DAMAGE)
    self.range = Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.RANGE)
    self.shot_speed = Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.SHOT_SPEED)
    self.luck = Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.LUCK)

    self.stats = {self.speed, self.fire_delay, self.damage, self.range, self.shot_speed, self.luck}

    -- TODO handle duality
    if self.player.number == 0 and self.player.is_real then
        table.insert(self.stats, Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.DEVIL, true))
        table.insert(self.stats, Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.ANGEL, true))
        table.insert(self.stats, Better_Coop_HUD.Stat.new(player_entity, Better_Coop_HUD.Stat.PLANETARIUM, true))
    end

    return self
end

function Better_Coop_HUD.Stats:render(edge, edge_indexed, edge_multipliers, additional_offset)
    local is_lower_text = self.player.number > 1
    local render_sprite = not is_lower_text and self.player.is_real
    local mirrored = ((self.player.number + 1) % 2) == 0

    local edge_multipliers2 = edge_multipliers
    edge_multipliers2.Y = 1

    local edge2 = Vector(edge_indexed.X, edge.Y)

    local pos = edge2 + (Better_Coop_HUD.config.stats.pos * edge_multipliers2)
    local text_pos = edge2 + ((Better_Coop_HUD.config.stats.text.pos + additional_offset) * edge_multipliers2)

    if mirrored then
        pos = pos + Better_Coop_HUD.config.stats.mirrored_offset
        text_pos = text_pos + Better_Coop_HUD.config.stats.text.mirrored_offset
    end

    if is_lower_text then
        text_pos = text_pos + (Better_Coop_HUD.config.stats.text.offset / 2)
    end

    for i = 0, #self.stats - 1, 1 do
        self.stats[i + 1]:render(
            pos + (Better_Coop_HUD.config.stats.offset * i),
            text_pos + (Better_Coop_HUD.config.stats.text.offset * i),
            render_sprite
        )
    end

end
