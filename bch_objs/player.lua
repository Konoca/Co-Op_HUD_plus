function Better_Coop_HUD.Player.new(player_entity, player_num)
    local self = setmetatable({}, Better_Coop_HUD.Player)

    self.player_entity = player_entity
    self.player_type = self.player_entity:GetPlayerType()
    self.index = self.player_entity.Index

    self.is_real = self:getIsReal()
    self.twin = nil

    self.number = player_num

    if not self.is_real then
        self.number = self.number - 1
    end

    local twin_entity = self.player_entity:GetOtherTwin()
    if twin_entity ~= nil and self.is_real then
        self.twin = Better_Coop_HUD.Player.new(twin_entity, player_num)
        self.twin.number = self.number
    end

    -- TODO T.Issac & T.Cain inventories

    self.health = Better_Coop_HUD.Health.new(player_entity)

    self.active_items = {
        [0] = Better_Coop_HUD.ActiveItem.new(player_entity, ActiveSlot.SLOT_PRIMARY),
        [1] = Better_Coop_HUD.ActiveItem.new(player_entity, ActiveSlot.SLOT_SECONDARY),
    }

    self.trinkets = {
        [0] = Better_Coop_HUD.Trinket.new(player_entity, Better_Coop_HUD.Trinket.SLOT_PRIMARY),
        [1] = Better_Coop_HUD.Trinket.new(player_entity, Better_Coop_HUD.Trinket.SLOT_SECONDARY),
    }

    self.pockets = Better_Coop_HUD.Pockets.new(player_entity, nil)

    self.stats = Better_Coop_HUD.Stats.new(player_entity, self)

    return self
end

function Better_Coop_HUD.Player:update(player_entity)
    self.health = Better_Coop_HUD.Health.new(player_entity)

    self.active_items = {
        [0] = Better_Coop_HUD.ActiveItem.new(player_entity, ActiveSlot.SLOT_PRIMARY),
        [1] = Better_Coop_HUD.ActiveItem.new(player_entity, ActiveSlot.SLOT_SECONDARY),
    }

    self.trinkets = {
        [0] = Better_Coop_HUD.Trinket.new(player_entity, Better_Coop_HUD.Trinket.SLOT_PRIMARY),
        [1] = Better_Coop_HUD.Trinket.new(player_entity, Better_Coop_HUD.Trinket.SLOT_SECONDARY),
    }

    self.pockets = Better_Coop_HUD.Pockets.new(player_entity, self)

    self.stats = Better_Coop_HUD.Stats.new(player_entity, self)

    self.player_entity = player_entity
    self.player_type = self.player_entity:GetPlayerType()
    self.index = self.player_entity.Index

    local twin_entity = self.player_entity:GetOtherTwin()
    if self.twin and twin_entity ~= nil and self.is_real then
        self.twin:update(twin_entity)
    end
end

function Better_Coop_HUD.Player:getIsReal()
    if self.player_type == PlayerType.PLAYER_ESAU then return false end
    return true
end

function Better_Coop_HUD.Player:render(screen_size, screen_center, horizontal_mirror, vertical_mirror, offset)
    if self.player_entity:IsCoopGhost() then return end

    -- TODO active/pocket item highlighting for Jacob & Esau

    local horizontal_edge = Better_Coop_HUD.config.offset.X + offset.X
    local horizontal_multiplier = 1

    local vertical_edge = Better_Coop_HUD.config.offset.Y + offset.Y
    local vertical_multiplier = 1

    if horizontal_mirror then
        horizontal_edge = screen_size.X - (horizontal_edge + Better_Coop_HUD.config.mirrored_extra_offset.X)
        horizontal_multiplier = -1
    end
    if vertical_mirror then
        vertical_edge = screen_size.Y - (vertical_edge + Better_Coop_HUD.config.mirrored_extra_offset.Y)
        vertical_multiplier = -1
    end

    -- active item
    for i = 0, #self.active_items, 1 do
        if not self.active_items[i] then goto skip_active_item end

        local item_pos = Vector(
            horizontal_edge + (Better_Coop_HUD.config.active_item[i].pos.X * horizontal_multiplier),
            vertical_edge + (Better_Coop_HUD.config.active_item[i].pos.Y * vertical_multiplier)
        )

        local barFlip = 1
        if not Better_Coop_HUD.config.active_item[i].chargebar.stay_on_right then
            barFlip = barFlip * horizontal_multiplier
        end

        local bar_pos = Vector(
            horizontal_edge + (Better_Coop_HUD.config.active_item[i].chargebar.pos.X * barFlip),
            vertical_edge + (Better_Coop_HUD.config.active_item[i].chargebar.pos.Y * vertical_multiplier)
        )

        self.active_items[i]:render(
            item_pos, bar_pos,
            Better_Coop_HUD.config.active_item[i].scale,
            Better_Coop_HUD.config.active_item[i].chargebar.display
        )
        ::skip_active_item::
    end

    -- trinket
    for i = 0, #self.trinkets, 1 do
        if not self.trinkets[i] then goto skip_trinket end

        local item_pos = Vector(
            horizontal_edge + (Better_Coop_HUD.config.trinket[i].pos.X * horizontal_multiplier),
            vertical_edge + (Better_Coop_HUD.config.trinket[i].pos.Y * vertical_multiplier)
        )

        self.trinkets[i]:render(item_pos, Better_Coop_HUD.config.trinket[i].scale)
        ::skip_trinket::
    end

    -- pocket items
    self.pockets:render(horizontal_edge, horizontal_multiplier, vertical_edge, vertical_multiplier)

    -- health
    self.health:render(
        horizontal_edge + (Better_Coop_HUD.config.health.pos.X * horizontal_multiplier),
        horizontal_multiplier,
        vertical_edge + (Better_Coop_HUD.config.health.pos.Y * vertical_multiplier),
        vertical_multiplier
    )

    -- stats & misc
    if self.is_real then
        self.stats:render(
            horizontal_edge + (Better_Coop_HUD.config.stats.pos.X * horizontal_multiplier),
            horizontal_multiplier,
            vertical_edge + Better_Coop_HUD.config.stats.pos.Y
        )
    end

    if self.twin then
        self.twin:render(
            screen_size,
            screen_center,
            horizontal_mirror,
            vertical_mirror,
            Better_Coop_HUD.config.twin_pos
        )
        self.twin.stats:render(
            horizontal_edge + (
                (Better_Coop_HUD.config.stats.pos.X + (Better_Coop_HUD.config.stats.space_between_icon_text * 1.6))
                * horizontal_multiplier
            ),
            horizontal_multiplier,
            vertical_edge + Better_Coop_HUD.config.stats.pos.Y
        )
    end
end
