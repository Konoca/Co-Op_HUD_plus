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
    if self.stat == Better_Coop_HUD.Stat.DEVIL then return Game():GetRoom():GetDevilRoomChance() * 100 end
    if self.stat == Better_Coop_HUD.Stat.ANGEL then return Game():GetRoom():GetDevilRoomChance() * 100 end
    if self.stat == Better_Coop_HUD.Stat.PLANETARIUM then return Game():GetLevel():GetPlanetariumChance() * 100 end
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
