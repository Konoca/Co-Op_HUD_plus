function Better_Coop_HUD.Player.new(player_entity, player_num)
    local self = setmetatable({}, Better_Coop_HUD.Player)

    self.player_entity = player_entity
    self.player_type = self.player_entity:GetPlayerType()
    self.index = self.player_entity.Index

    self.is_real = self:getIsReal()
    self.twin = nil

    self.number = player_num

    local twin_entity = self.player_entity:GetOtherTwin()
    if twin_entity ~= nil and self.is_real then
        self.twin = Better_Coop_HUD.Player.new(twin_entity, player_num)
        self.twin.number = self.number
    end

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

    self.inventory = Better_Coop_HUD.Inventory.new(player_entity, nil)
    if Better_Coop_HUD.SAVED_PLAYER_DATA[tostring(self.player_entity.ControllerIndex)] then
        self.inventory.inv = Better_Coop_HUD.SAVED_PLAYER_DATA[tostring(self.player_entity.ControllerIndex)]
    end

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

    self.inventory = Better_Coop_HUD.Inventory.new(player_entity, self)

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

    local edge = Better_Coop_HUD.config.offset + offset
    local edge_multipliers = Vector(1, 1)
    local edge_indexed = Better_Coop_HUD.config.offset + offset

    if horizontal_mirror then
        edge_indexed.X = screen_size.X - (edge.X + Better_Coop_HUD.config.mirrored_extra_offset.X)
        edge_multipliers.X = -1
    end
    if vertical_mirror then
        edge_indexed.Y = screen_size.Y - (edge.Y + Better_Coop_HUD.config.mirrored_extra_offset.Y)
        edge_multipliers.Y = -1
    end

    -- active item
    for i = 0, #self.active_items, 1 do
        if not self.active_items[i] then goto skip_active_item end

        local item_pos = edge_indexed + (Better_Coop_HUD.config.active_item[i].pos * edge_multipliers)

        local barFlip = 1
        if not Better_Coop_HUD.config.active_item[i].chargebar.stay_on_right then
            barFlip = barFlip * edge_multipliers.X
        end

        local bar_pos = edge_indexed + (
            Better_Coop_HUD.config.active_item[i].chargebar.pos * Vector(barFlip, edge_multipliers.Y)
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

        local item_pos = edge_indexed + (Better_Coop_HUD.config.trinket[i].pos * edge_multipliers)

        self.trinkets[i]:render(item_pos, Better_Coop_HUD.config.trinket[i].scale)
        ::skip_trinket::
    end

    -- pocket items
    self.pockets:render(edge_indexed, edge_multipliers)

    -- health
    self.health:render(edge_indexed, edge_multipliers)

    -- inventory
    self.inventory:render(edge_indexed, edge_multipliers)

    -- stats & misc
    if self.is_real then
        self.stats:render(edge, edge_indexed, edge_multipliers, Vector(0, 0))
    end

    if self.twin then
        self.twin:render(
            screen_size,
            screen_center,
            horizontal_mirror,
            vertical_mirror,
            Better_Coop_HUD.config.twin_pos
        )

        -- TODO does not render correctly for P3 & P4
        self.twin.stats:render(edge, edge_indexed, edge_multipliers, Better_Coop_HUD.config.stats.text.twin_offset)
    end
end
