function CoopHUDplus.Player.new(player_entity, player_num)
    local self = setmetatable({}, CoopHUDplus.Player)

    self.player_entity = player_entity
    self.player_type = self.player_entity:GetPlayerType()
    self.index = self.player_entity.Index

    self.is_real = self:getIsReal()
    self.twin = nil

    self.number = player_num

    local twin_entity = self.player_entity:GetOtherTwin()
    if twin_entity ~= nil and self.is_real then
        self.twin = CoopHUDplus.Player.new(twin_entity, player_num)
        self.twin.number = self.number
    end

    self.health = CoopHUDplus.Health.new(player_entity)

    self.active_items = {
        [0] = CoopHUDplus.ActiveItem.new(player_entity, ActiveSlot.SLOT_PRIMARY),
        [1] = CoopHUDplus.ActiveItem.new(player_entity, ActiveSlot.SLOT_SECONDARY),
    }

    self.trinkets = {
        [0] = CoopHUDplus.Trinket.new(player_entity, CoopHUDplus.Trinket.SLOT_PRIMARY),
        [1] = CoopHUDplus.Trinket.new(player_entity, CoopHUDplus.Trinket.SLOT_SECONDARY),
    }

    self.pockets = CoopHUDplus.Pockets.new(player_entity, nil)

    self.stats = CoopHUDplus.Stats.new(player_entity, self)

    self.inventory = CoopHUDplus.Inventory.new(player_entity, nil)
    if CoopHUDplus.SAVED_PLAYER_DATA[tostring(self.player_entity.ControllerIndex)] then
        self.inventory.inv = CoopHUDplus.SAVED_PLAYER_DATA[tostring(self.player_entity.ControllerIndex)]
    end

    return self
end

function CoopHUDplus.Player:update(player_entity)
    self.health = CoopHUDplus.Health.new(player_entity)

    self.active_items = {
        [0] = CoopHUDplus.ActiveItem.new(player_entity, ActiveSlot.SLOT_PRIMARY),
        [1] = CoopHUDplus.ActiveItem.new(player_entity, ActiveSlot.SLOT_SECONDARY),
    }

    self.trinkets = {
        [0] = CoopHUDplus.Trinket.new(player_entity, CoopHUDplus.Trinket.SLOT_PRIMARY),
        [1] = CoopHUDplus.Trinket.new(player_entity, CoopHUDplus.Trinket.SLOT_SECONDARY),
    }

    self.pockets = CoopHUDplus.Pockets.new(player_entity, self)

    self.stats = CoopHUDplus.Stats.new(player_entity, self)

    self.inventory = CoopHUDplus.Inventory.new(player_entity, self)

    self.player_entity = player_entity
    self.player_type = self.player_entity:GetPlayerType()
    self.index = self.player_entity.Index

    local twin_entity = self.player_entity:GetOtherTwin()
    if self.twin and twin_entity ~= nil and self.is_real then
        self.twin:update(twin_entity)
    end
end

function CoopHUDplus.Player:getIsReal()
    if self.player_type == PlayerType.PLAYER_ESAU then return false end
    return true
end

function CoopHUDplus.Player:render(screen_size, screen_center, horizontal_mirror, vertical_mirror, offset, pColor)
    local doRender = true
    if self.player_entity:IsCoopGhost() then doRender = false end

    -- TODO active/pocket item highlighting for Jacob & Esau

    local edge = CoopHUDplus.config.offset + offset
    local edge_multipliers = Vector(1, 1)
    local edge_indexed = CoopHUDplus.config.offset + offset

    if horizontal_mirror then
        edge_indexed.X = screen_size.X - (edge.X + CoopHUDplus.config.mirrored_extra_offset.X)
        edge_multipliers.X = -1
    end
    if vertical_mirror then
        edge_indexed.Y = screen_size.Y - (edge.Y + CoopHUDplus.config.mirrored_extra_offset.Y)
        edge_multipliers.Y = -1
    end

    -- active item
    for i = 0, #self.active_items, 1 do
        if not self.active_items[i] or not doRender then goto skip_active_item end

        local item_pos = edge_indexed + (CoopHUDplus.config.active_item[i].pos * edge_multipliers)

        local barFlip = 1
        if not CoopHUDplus.config.active_item[i].chargebar.stay_on_right then
            barFlip = barFlip * edge_multipliers.X
        end

        local bar_pos = edge_indexed + (
            CoopHUDplus.config.active_item[i].chargebar.pos * Vector(barFlip, edge_multipliers.Y)
        )

        self.active_items[i]:render(
            item_pos, bar_pos,
            CoopHUDplus.config.active_item[i].scale,
            CoopHUDplus.config.active_item[i].chargebar.display
        )
        ::skip_active_item::
    end

    -- trinket
    for i = 0, #self.trinkets, 1 do
        if not self.trinkets[i] or not doRender then goto skip_trinket end

        local item_pos = edge_indexed + (CoopHUDplus.config.trinket[i].pos * edge_multipliers)

        self.trinkets[i]:render(item_pos, CoopHUDplus.config.trinket[i].scale)
        ::skip_trinket::
    end

    -- pocket items
    if doRender then self.pockets:render(edge_indexed, edge_multipliers) end

    -- health
    if doRender then self.health:render(edge_indexed, edge_multipliers) end

    -- inventory
    if doRender then self.inventory:render(edge_indexed, edge_multipliers) end

    -- stats & misc
    if self.is_real then
        self.stats:render(edge, edge_indexed, edge_multipliers, Vector(0, 0), pColor)
    end

    if self.twin then
        self.twin:render(
            screen_size,
            screen_center,
            horizontal_mirror,
            vertical_mirror,
            CoopHUDplus.config.twin_pos
        )

        self.twin.stats:render(edge, edge_indexed, edge_multipliers, CoopHUDplus.config.stats.text.twin_offset, pColor)
    end
end
