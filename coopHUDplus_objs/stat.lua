function CoopHUDplus.Stat.new(player_entity, stat, is_percent)
    local self = setmetatable({}, CoopHUDplus.Stat)

    self.player_entity = player_entity
    self.stat = stat
    self.is_percent = is_percent

    self.value = self:getValue()
    self.sprite = self:getSprite()

    return self
end

function CoopHUDplus.Stat:getValue()
    if self.stat == CoopHUDplus.Stat.SPEED then return self.player_entity.MoveSpeed end
    if self.stat == CoopHUDplus.Stat.FIRE_DELAY then return 30 / (self.player_entity.MaxFireDelay + 1) end
    if self.stat == CoopHUDplus.Stat.DAMAGE then return self.player_entity.Damage end
    if self.stat == CoopHUDplus.Stat.RANGE then return self.player_entity.TearRange / 40 end
    if self.stat == CoopHUDplus.Stat.SHOT_SPEED then return self.player_entity.ShotSpeed end
    if self.stat == CoopHUDplus.Stat.LUCK then return self.player_entity.Luck end

    if self.stat == CoopHUDplus.Stat.PLANETARIUM then return Game():GetLevel():GetPlanetariumChance() * 100 end

    local chances = self:getAngelDevilChance()
    if chances.duality and self.stat == CoopHUDplus.Stat.DUALITY then return chances.devil * 100 end

    if not chances.duality and self.stat == CoopHUDplus.Stat.DEVIL then return chances.devil * 100 end
    if not chances.duality and self.stat == CoopHUDplus.Stat.ANGEL then return chances.angel * 100 end

    return nil
end

function CoopHUDplus.Stat:getAngelDevilChance()
    local game = Game()
    local level = game:GetLevel()
    local room = game:GetRoom()
    local stage = level:GetStage()

    -- stages where you cant get a deal
    local disallowed_stages = {
        [LevelStage.STAGE1_1] = true,
        [LevelStage.STAGE4_3] = true,
        [LevelStage.STAGE5] = true,
        [LevelStage.STAGE6] = true,
        [LevelStage.STAGE7] = true,
        [LevelStage.STAGE8] = true,
    }

    local chances = {
        deal = 0.0,
        calc = 0.0,
        angel = 0.0,
        devil = 0.0,
        duality = false,
    }

    if level:IsPreAscent() then return chances end
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
    local book_of_virtues = false
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
        if p:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then book_of_virtues = true end
        -- if p:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then duality = true end
        if p:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then chances.duality = true end
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
    local devil_spawned = game:GetStateFlag(GameStateFlag.STATE_DEVILROOM_SPAWNED)
    local devil_visited = game:GetStateFlag(GameStateFlag.STATE_DEVILROOM_VISITED)
    local devil_item_taken = game:GetDevilRoomDeals() > 0
    local angel_spawned = game:GetStateFlag(GameStateFlag.STATE_FAMINE_SPAWNED) -- repurposed state in Rep
    if devil_visited and not devil_item_taken then
        chances.calc = 0.5
        for i = 1, #mods, 1 do
            chances.calc = chances.calc * mods[i]
        end

        chances.calc = 1.0 - (chances.calc * (1.0 - level:GetAngelRoomChance()))
    end

    chances.devil = chances.deal * (1.0 - chances.calc)
    chances.angel = chances.deal * chances.calc

    if (devil_spawned and not devil_visited) or book_of_virtues then
        local tmp = chances.devil
        chances.devil = chances.angel
        chances.angel = tmp

        if book_of_virtues and angel_spawned then
            chances.devil = chances.angel * .375
            chances.angel = chances.angel - chances.devil
            return chances
        end
    end

    if devil_spawned and angel_spawned and not devil_item_taken then
        local tmp = chances.devil + chances.angel
        chances.devil = tmp / 2.0
        chances.angel = tmp / 2.0
    end

    return chances
end

function CoopHUDplus.Stat:getSprite()
    local sprite = Sprite()
    sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.stats, true)
    sprite:SetFrame('Idle', self.stat)
    return sprite
end


function CoopHUDplus.Stat:render(pos_vector, text_pos_vector, render_icon)
    if self.value == nil then return end

    if render_icon then
        self.sprite.Scale = CoopHUDplus.config.stats.scale
        self.sprite:Render(pos_vector)
    end

    -- TODO visual difference if stat changed
    Isaac.RenderScaledText(
        string.format(self.is_percent and '%.1f%%' or '%.2f', self.value),
        text_pos_vector.X, text_pos_vector.Y,
        CoopHUDplus.config.stats.text.scale.X,
        CoopHUDplus.config.stats.text.scale.Y,
        1, 1, 1, 0.5
    )
end

function CoopHUDplus.Stats.new(player_entity, player)
    local self = setmetatable({}, CoopHUDplus.Stats)

    self.player_entity = player_entity
    self.player = player

    self.speed = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.SPEED)
    self.fire_delay = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.FIRE_DELAY)
    self.damage = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.DAMAGE)
    self.range = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.RANGE)
    self.shot_speed = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.SHOT_SPEED)
    self.luck = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.LUCK)

    self.stats = {self.speed, self.fire_delay, self.damage, self.range, self.shot_speed, self.luck}

    -- TODO handle duality
    if self.player.number == 0 and self.player.is_real then
        local duality = CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.DUALITY, true)
        if duality.value == nil then
            table.insert(self.stats, CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.DEVIL, true))
            table.insert(self.stats, CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.ANGEL, true))
        else
            table.insert(self.stats, duality)
        end
        table.insert(self.stats, CoopHUDplus.Stat.new(player_entity, CoopHUDplus.Stat.PLANETARIUM, true))
    end

    return self
end

function CoopHUDplus.Stats:render(edge, edge_indexed, edge_multipliers, additional_offset)
    local is_lower_text = self.player.number > 1
    local render_sprite = not is_lower_text and self.player.is_real
    local mirrored = ((self.player.number + 1) % 2) == 0

    local edge_multipliers2 = edge_multipliers
    edge_multipliers2.Y = 1

    local edge2 = Vector(edge_indexed.X, edge.Y)

    local pos = edge2 + (CoopHUDplus.config.stats.pos * edge_multipliers2)
    local text_pos = edge2 + ((CoopHUDplus.config.stats.text.pos + additional_offset) * edge_multipliers2)

    if mirrored then
        pos = pos + CoopHUDplus.config.stats.mirrored_offset
        text_pos = text_pos + CoopHUDplus.config.stats.text.mirrored_offset
    end

    if is_lower_text then
        text_pos = text_pos + (CoopHUDplus.config.stats.text.offset / 2)
    end

    for i = 0, #self.stats - 1, 1 do
        self.stats[i + 1]:render(
            pos + (CoopHUDplus.config.stats.offset * i),
            text_pos + (CoopHUDplus.config.stats.text.offset * i),
            render_sprite
        )
    end

end
