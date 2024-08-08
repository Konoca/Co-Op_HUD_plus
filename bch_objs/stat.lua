function Better_Coop_HUD.Stat.new(player_entity, stat)
    local self = setmetatable({}, Better_Coop_HUD.Stat)

    self.player_entity = player_entity
    self.stat = stat

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
end

function Better_Coop_HUD.Stat:getSprite()
    local sprite = Sprite()
    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.stats, true)
    sprite:SetFrame('Idle', self.stat)
    return sprite
end


-- TODO p3 and p4 dont render
function Better_Coop_HUD.Stat:render(pos_vector, text_pos_vector, scale, render_icon, is_upper_text)
    if render_icon then
        self.sprite.Scale = scale
        self.sprite:Render(pos_vector)
    end

    if is_upper_text then
        text_pos_vector.Y = text_pos_vector.Y - (Better_Coop_HUD.config.stats.space_between_icon_text / 2)
    end

    -- TODO visual difference if stat changed
    Isaac.RenderScaledText(
        string.format('%.2f', self.value),
        text_pos_vector.X, text_pos_vector.Y,
        scale.X / 2,
        scale.Y / 2,
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

    return self
end

local function _render(stat, pos, offset, is_upper_text, render_sprite, mirrored, horizontal_edge, horizontal_multiplier, vertical_edge)
    pos.X = horizontal_edge + (offset.X * horizontal_multiplier)
    pos.Y = vertical_edge + offset.Y

    local additional_text_offset = 0

    if mirrored then
        pos.X = pos.X + Better_Coop_HUD.config.stats.mirrored_offset.X
        pos.Y = pos.Y + Better_Coop_HUD.config.stats.mirrored_offset.Y
        additional_text_offset = Better_Coop_HUD.config.stats.space_between_icon_text * 1.5
    end

    local text_pos = Vector(
        pos.X + ((Better_Coop_HUD.config.stats.space_between_icon_text + additional_text_offset) * horizontal_multiplier),
        pos.Y
    )

    stat:render(
        pos,
        text_pos,
        Better_Coop_HUD.config.stats.scale,
        render_sprite,
        is_upper_text
    )

    offset.Y = offset.Y + Better_Coop_HUD.config.stats.space_between_icons

    return offset
end

function Better_Coop_HUD.Stats:render(horizontal_edge, horizontal_multiplier, vertical_edge)
    local is_upper_text = self.player.number < 2
    local render_sprite = is_upper_text and self.player.is_real
    local mirrored = ((self.player.number + 1) % 2) == 0

    local offset = Vector(0, 0)
    local pos = Vector(0, 0)

    local stats = {self.speed, self.fire_delay, self.damage, self.range, self.shot_speed, self.luck}
    for i = 1, #stats, 1 do
        offset = _render(
            stats[i],
            pos, offset,
            is_upper_text,
            render_sprite,
            mirrored,
            horizontal_edge, horizontal_multiplier, vertical_edge
        )
    end
end
