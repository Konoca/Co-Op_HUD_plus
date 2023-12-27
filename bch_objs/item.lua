-- Item
function Better_Coop_HUD.Item.new(entity, slot, item_id)
end

function Better_Coop_HUD.Item:getSprite()
end

-- Active Item
function Better_Coop_HUD.ActiveItem.new(entity, slot)
    local self = setmetatable({}, Better_Coop_HUD.ActiveItem)

    self.slot = slot
    self.entity = entity

    self.id = entity:GetActiveItem(slot)
    self.current_charge = entity:GetActiveCharge(slot)

    if Isaac.GetItemConfig():GetCollectible(self.id) == nil then
        return nil
    end

    self.max_charge = Isaac.GetItemConfig():GetCollectible(self.id).MaxCharges
    self.extra_charge = entity:GetBatteryCharge(slot)
    self.soul_charge = entity:GetSoulCharge()
    self.blood_charge = entity:GetBloodCharge()

    self.sprite = self:getSprite()
    self.chargeBar = self:getChargeBar()
    return self
end

function Better_Coop_HUD.ActiveItem:getSprite()
    if self.id == 0 then return nil end

    -- TODO dInfinity
    -- TODO other special case active items

    local sprite = Sprite()
    local path = Isaac.GetItemConfig():GetCollectible(self.id).GfxFileName
    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.active_item, false)
    sprite:ReplaceSpritesheet(0, path)
    sprite:ReplaceSpritesheet(1, path)
    sprite:ReplaceSpritesheet(2, path)

    local bookpath = self:getBookPath()
    if bookpath and self.slot == ActiveSlot.SLOT_PRIMARY then
        sprite:ReplaceSpritesheet(3, bookpath)
        sprite:ReplaceSpritesheet(4, bookpath)
        if Better_Coop_HUD.config.active_item.book_charge_outline then sprite:ReplaceSpritesheet(5, bookpath) end
    end

    local frame = 0
    if self.current_charge >= self.max_charge and self.max_charge > 0 then frame = 1 end

    sprite:SetFrame(Better_Coop_HUD.Item.ANIMATION_NAME, frame)
    sprite:LoadGraphics()
    return sprite
end

function Better_Coop_HUD.ActiveItem:getChargeBar()
    if self.id == 0 then return nil end

    -- TODO 4.5volt

    local sprite = {
        overlay = Sprite(),
        charge = Sprite(),
        bg = Sprite(),
        extra = Sprite(),
        beth = Sprite(),
    }

    sprite.overlay:Load(Better_Coop_HUD.PATHS.ANIMATIONS.chargebar, true)
    sprite.overlay:SetFrame('BarOverlay'..self.max_charge, 0)

    sprite.charge:Load(Better_Coop_HUD.PATHS.ANIMATIONS.chargebar, true)
    sprite.charge:SetFrame('BarFull', 0)

    sprite.bg:Load(Better_Coop_HUD.PATHS.ANIMATIONS.chargebar, true)
    sprite.bg:SetFrame('BarEmpty', 0)

    local extra_color = Color(1, 1, 1, 1, 0, 0, 0)
    local beth_color = Color(1, 1, 1, 1, 0, 0, 0)

    extra_color:SetColorize(1.8, 1.8, 0, 1)

    -- Colors taken from coopHUD, credit to Srokks
    beth_color:SetColorize(0.8, 0.9, 1.8, 1)
    if self.entity:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
        beth_color:SetColorize(1, 0.2, 0.2, 1)
    end

    sprite.extra:Load(Better_Coop_HUD.PATHS.ANIMATIONS.chargebar, true)
    sprite.extra:SetFrame('BarFull', 0)
    sprite.extra.Color = extra_color

    sprite.beth:Load(Better_Coop_HUD.PATHS.ANIMATIONS.chargebar, true)
    sprite.beth:SetFrame('BarFull', 0)
    sprite.beth.Color = beth_color

    return sprite
end

function Better_Coop_HUD.ActiveItem:getBookSprite()
    if self.slot ~= ActiveSlot.SLOT_PRIMARY then return nil end

    local bookpath = self:getBookPath()
    if not bookpath then return nil end

    local sprite = Sprite()
    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.book, false)

    sprite:ReplaceSpritesheet(1, bookpath)

    sprite:SetFrame(Better_Coop_HUD.Item.ANIMATION_NAME, 0)
    sprite:LoadGraphics()
    return Sprite()
end

function Better_Coop_HUD.ActiveItem:getBookPath()
    local bov = CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES
    local bob = CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL

    local hasVirtues = self.entity:HasCollectible(bov) and self.id ~= bov
    local hasBelial = self.entity:HasCollectible(bob) and self.id ~= bob

    if hasVirtues and hasBelial then return 'gfx/ui/hud_bookofvirtueswithbelial.png' end
    if hasVirtues then return 'gfx/ui/hud_bookofvirtues.png' end
    if hasBelial then return 'gfx/ui/hud_bookofbelial.png' end
    return nil
end

function Better_Coop_HUD.ActiveItem:render(item_pos_vec, bar_pos_vec, scale, display_charge)
    self.sprite.Scale = scale
    self.chargeBar.bg.Scale = scale
    self.chargeBar.beth.Scale = scale
    self.chargeBar.charge.Scale = scale
    self.chargeBar.extra.Scale = scale
    self.chargeBar.overlay.Scale = scale

    if self:getBookPath() and self.slot == ActiveSlot.SLOT_PRIMARY then
        item_pos_vec = Vector(
            item_pos_vec.X + Better_Coop_HUD.config.active_item.book_correction_offset.X,
            item_pos_vec.Y + Better_Coop_HUD.config.active_item.book_correction_offset.Y
        )
        -- bar_pos_vec = Vector(bar_pos_vec.X, bar_pos_vec.Y)
    end
    self.sprite:Render(item_pos_vec)

    if self.current_charge and self.max_charge and self.max_charge > 0 and display_charge then
        self.chargeBar.bg:Render(bar_pos_vec)
        self.chargeBar.beth:Render(bar_pos_vec, self:getChargeBarCharge(self.soul_charge))
        self.chargeBar.beth:Render(bar_pos_vec, self:getChargeBarCharge(self.blood_charge))
        self.chargeBar.charge:Render(bar_pos_vec, self:getChargeBarCharge(self.current_charge))
        self.chargeBar.extra:Render(bar_pos_vec, self:getChargeBarCharge(self.extra_charge))
        self.chargeBar.overlay:Render(bar_pos_vec)
    end
end

function Better_Coop_HUD.ActiveItem:getChargeBarCharge(current_charge)
    if not current_charge then return Vector(1,1) end

    -- 22 = 1/6
    -- 10 = 4/6
    -- 7 = 5/6
    -- 3 = full bar
    -- 26 = empty bar
    if current_charge <= 0 then
        return Vector(1, 26)
    end

    if current_charge >= self.max_charge then
        return Vector(1, 3)
    end

    local chargeMap = {
        [2] = {
            [1] = 14,   -- 1/2
        },
        [3] = {
            [1] = 19,   -- 1/3
            [2] = 10,   -- 2/3
        },
        [4] = {
            [1] = 20,   -- 1/4
            [2] = 14,   -- 1/2
            [3] = 8,    -- 3/4
        },
        [5] = {
            -- TODO ..? The sprite exists but I can't find any items that use it. Might need to do for mod compatibility
        },
        [6] = {
            [1] = 22,   -- 1/6
            [2] = 19,   -- 1/3
            [3] = 14,   -- 1/2
            [4] = 10,   -- 2/3
            [5] = 7,    -- 5/6
        },
        [8] = {
            -- TODO ..? Same as 5-room
        },
        [12] = {
            [1] = 24,   -- 1/12
            [2] = 22,   -- 1/6
            [3] = 20,   -- 1/4
            [4] = 18,   -- 1/3
            [5] = 16,
            [6] = 14,   -- 1/2
            [7] = 12,
            [8] = 10,   -- 2/3
            [9] = 8,    -- 3/4
            [10] = 6,
            [11] = 4,
        },
    }
    return Vector(1, chargeMap[self.max_charge][current_charge])
end

-- Trinket
function Better_Coop_HUD.Trinket.new(entity, slot)
    local self = setmetatable({}, Better_Coop_HUD.Trinket)

    self.slot = slot
    self.player_entity = entity

    self.id = entity:GetTrinket(slot)
    self.sprite = self:getSprite()

    return self
end

function Better_Coop_HUD.Trinket:getSprite()
    if self.id == TrinketType.TRINKET_NULL then return nil end

    local sprite = Sprite()
	local path = Isaac.GetItemConfig():GetTrinket(self.id).GfxFileName

	sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.trinket, false)
	sprite:ReplaceSpritesheet(1, path)

	sprite:LoadGraphics()
	sprite:SetFrame(Better_Coop_HUD.Item.ANIMATION_NAME, 0)

	return sprite
end

function Better_Coop_HUD.Trinket:render(pos_vector, scale)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite:Render(pos_vector)
end

-- Pocket Item (pill, card, rune)
function Better_Coop_HUD.PocketItem.new(entity, slot)
    local self = setmetatable({}, Better_Coop_HUD.PocketItem)

    self.id = 0
    self.slot = slot
    self.player_entity = entity
    self.type = Better_Coop_HUD.PocketItem.TYPE_NONE

    -- Is item a card? (runes are labeled as cards)
    if self.player_entity:GetCard(slot) > 0 then
        self.id = self.player_entity:GetCard(slot)
        self.type = Better_Coop_HUD.PocketItem.TYPE_CARD
        self.item_config = Isaac.GetItemConfig():GetCard(self.id)

        self.name = '???'

        if self.item_config then
            -- TODO add ID to name as roman numeral
            local name = self.item_config.Name
            name = name:sub(2, -5)
            name = name:gsub('_', ' ')
            name = name:lower():gsub('%f[%a].', string.upper)
            self.name = name
        end

    end

    -- Is item a pill?
    if self.player_entity:GetPill(slot) > 0 then
        self.id = self.player_entity:GetPill(slot)
        self.type = Better_Coop_HUD.PocketItem.TYPE_PILL

        local effectID = Better_Coop_HUD.pills[self.id]
        if not effectID then effectID = PillEffect.PILLEFFECT_NULL end

        self.item_config = Isaac.GetItemConfig():GetPillEffect(effectID)

        -- self.name = '???'
        --
        -- if self.item_config then
        --     local name = self.item_config.Name
        --     name = name:sub(2, -5)
        --     name = name:gsub('_', ' ')
        --     name = name:lower():gsub('%f[%a].', string.upper)
        --     self.name2 = name
        -- end

        -- TODO do not display name if pill hasn't been used in run yet
        self.name = Better_Coop_HUD.PILL[effectID]
    end

    self.sprite = self:getSprite()

    return self
end

function Better_Coop_HUD.PocketItem:getSprite()
    if self.type == Better_Coop_HUD.PocketItem.TYPE_NONE then return nil end

    local sprite = Sprite()
    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.pocket_items, false)

    local animation_map = {
        [Better_Coop_HUD.PocketItem.TYPE_PILL] = 'pills',
        [Better_Coop_HUD.PocketItem.TYPE_CARD] = 'cards',
    }
    local animation = animation_map[self.type]

    sprite:ReplaceSpritesheet(0, 'gfx/ui/ui_cardspills.png')
    sprite:ReplaceSpritesheet(1, 'gfx/ui/ui_cardfronts.png')
    sprite:LoadGraphics()

    sprite:SetFrame(animation, self.id)
    return sprite
end

function Better_Coop_HUD.PocketItem:render(pos_vector, scale)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite:Render(pos_vector)
end

-- Pocket Active Item (tainted characters)
function Better_Coop_HUD.PocketActiveItem.new(entity, slot)
    local self = setmetatable({}, Better_Coop_HUD.PocketActiveItem)
    self.id = 0
    self.slot = slot
    self.type = Better_Coop_HUD.PocketItem.TYPE_NONE

    if entity:GetActiveItem(slot) > 0 then
        self.id = entity:GetActiveItem(slot)
        self.type = Better_Coop_HUD.PocketItem.TYPE_ACTIVE
        self.item_config = Isaac.GetItemConfig():GetCollectible(self.id)

        self.name = '???'

        if self.item_config then
            local name = self.item_config.Name
            name = name:sub(2, -5)
            name = name:gsub('_', ' ')
            name = name:lower():gsub('%f[%a].', string.upper)
            self.name = name
        end

        self.current_charge = entity:GetActiveCharge(slot)
        self.max_charge = Isaac.GetItemConfig():GetCollectible(self.id).MaxCharges
        self.sprite = self:getSprite()
    end

    return self
end

function Better_Coop_HUD.PocketActiveItem:getSprite()
    if self.id == 0 then return nil end

    local sprite = Sprite()
    local path = Isaac.GetItemConfig():GetCollectible(self.id).GfxFileName

    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.active_item, false)
    sprite:ReplaceSpritesheet(0, path)
    sprite:ReplaceSpritesheet(1, path)
    sprite:ReplaceSpritesheet(2, path)

    local frame = 0
    if self.current_charge >= self.max_charge and self.max_charge > 0 then frame = 1 end

    sprite:SetFrame(Better_Coop_HUD.Item.ANIMATION_NAME, frame)
    sprite:LoadGraphics()
    return sprite
end

function Better_Coop_HUD.PocketActiveItem:render(pos_vector, scale)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite:Render(pos_vector)
end

function Better_Coop_HUD.Pockets.new(player_entity, previous_player)
    local self = setmetatable({}, Better_Coop_HUD.Pockets)

    self.player_entity = player_entity
    self.previous_player = previous_player

    self.items = {
        [0] = Better_Coop_HUD.PocketItem.new(player_entity, Better_Coop_HUD.PocketItem.SLOT_PRIMARY),
        [1] = Better_Coop_HUD.PocketItem.new(player_entity, Better_Coop_HUD.PocketItem.SLOT_SECONDARY),
        [2] = Better_Coop_HUD.PocketItem.new(player_entity, Better_Coop_HUD.PocketItem.SLOT_TERTIARY),
        [3] = Better_Coop_HUD.PocketItem.new(player_entity, Better_Coop_HUD.PocketItem.SLOT_QUATERNARY),
    }

    self.actives = {
        -- permanent (tainted active items)
        [0] = Better_Coop_HUD.PocketActiveItem.new(player_entity, ActiveSlot.SLOT_POCKET),

        -- single use (ex. dice bag)
        [1] = Better_Coop_HUD.PocketActiveItem.new(player_entity, ActiveSlot.SLOT_POCKET2),
    }

    self.total_items = self:getTotal()

    if previous_player ~= nil then
        self.order = self:determineOrder()
    else
        self.order = self:initOrder()
    end

    return self
end

function Better_Coop_HUD.Pockets:getTotal()
    local total = 0
    for i = 0, #self.items, 1 do
        if self.items[i].type ~= Better_Coop_HUD.PocketItem.TYPE_NONE then
            total = total + 1
        end
    end
    for i = 0, #self.actives, 1 do
        if self.actives[i].type ~= Better_Coop_HUD.PocketItem.TYPE_NONE then
            total = total + 1
        end
    end
    return total
end

function Better_Coop_HUD.Pockets:increment_slot(slot)
    local new = slot + 1
    if new >= self.total_items then
        new = 0
    end
    return new
end
function Better_Coop_HUD.Pockets:decrement_slot(slot)
    local new = slot - 1
    if new <= 0 then
        new = self.total_items - 1
    end
    return new
end

function Better_Coop_HUD.Pockets:initOrder()
    local order = {}
    for i = 0, #self.items do
        order[i] = self.items[i]
    end

    for i = 0, #order, 1 do
        if order[i].type == Better_Coop_HUD.PocketItem.TYPE_NONE then
            self.actives[0].slot = i
            order[i] = self.actives[0]
            break
        end
    end

    return order
end

function Better_Coop_HUD.Pockets:determineOrder()
    -- TODO issues happen when you get a dice from dice bag 2 rooms in a row
    -- TODO issues happen when only have pocket active and dice from dice bag
    if self.previous_player == nil or self.previous_player.pockets == nil then
        return self:initOrder()
    end

    local order = {}
    for i = 0, #self.items do
        order[i] = self.items[i]
    end

    local hasPermanent = self.actives[0].type == Better_Coop_HUD.PocketItem.TYPE_ACTIVE
    local hasSingleUse = self.actives[1].type == Better_Coop_HUD.PocketItem.TYPE_ACTIVE

    local hadSingleUse = self.previous_player.pockets.actives[1].type == Better_Coop_HUD.PocketItem.TYPE_ACTIVE

    local singleUseDone = not hasSingleUse

    if not hasPermanent and not hasSingleUse then
        return order
    end

    local newSingleUse = hadSingleUse and hasSingleUse and self.actives[1].id ~= self.previous_player.pockets.actives[1].id

    if ((not hadSingleUse and hasSingleUse) or newSingleUse) and order[0].type == Better_Coop_HUD.PocketItem.TYPE_NONE then
        self.actives[1].slot = 0
        order[0] = self.actives[1]
        singleUseDone = true
    end

    if hasPermanent and singleUseDone then
        for i = 0, #order, 1 do
            if order[i].type == Better_Coop_HUD.PocketItem.TYPE_NONE then
                self.actives[0].slot = i
                order[i] = self.actives[0]
                break
            end
        end
    end

    if singleUseDone then
        return order
    end

    local zeros = {}
    for i = 0, self.total_items - 1 do
        if order[i].id == 0 then
            table.insert(zeros, i)
        end
    end

    local oldPermaSlot = self.previous_player.pockets.actives[0].slot
    local oldSingleUseSlot = self.previous_player.pockets.actives[1].slot
    local isPermaFirst = oldPermaSlot < oldSingleUseSlot
    local flipPermaOrder = zeros[2] == self.total_items - 1

    if hasPermanent and hasSingleUse then
        local permaSlot = 1
        if flipPermaOrder then isPermaFirst = not isPermaFirst end
        if not isPermaFirst then permaSlot = 2 end

        local singleSlot = 2
        if not isPermaFirst then singleSlot = 1 end

        local newPermaSlot = zeros[permaSlot]
        local newSingleUseSlot = zeros[singleSlot]

        if newPermaSlot == oldSingleUseSlot and newSingleUseSlot == oldPermaSlot then
            newPermaSlot = oldPermaSlot
            newSingleUseSlot = oldSingleUseSlot
        end

        order[newPermaSlot] = self.actives[0]
        self.actives[0].slot = newPermaSlot

        order[newSingleUseSlot] = self.actives[1]
        self.actives[1].slot = newSingleUseSlot

        return order
    end

    if hasPermanent then
        order[zeros[1]] = self.actives[0]
        self.actives[0].slot = zeros[1]

        return order
    end

    if hasSingleUse then
        order[zeros[1]] = self.actives[1]
        self.actives[1].slot = zeros[1]

        return order
    end

    return order
end

function Better_Coop_HUD.Pockets:render(edge_indexed, edge_multipliers)
    for i = 0, #self.order, 1 do
        if not self.order[i] then goto skip_pocket end

        local item_pos = edge_indexed + (Better_Coop_HUD.config.pocket[i].pos * edge_multipliers)

        self.order[i]:render(item_pos, Better_Coop_HUD.config.pocket[i].scale)
        ::skip_pocket::
    end

    if self.order[0].type ~= Better_Coop_HUD.PocketItem.TYPE_NONE and Better_Coop_HUD.config.pocket.text.display then
        local text_pos = edge_indexed + (Better_Coop_HUD.config.pocket.text.pos * edge_multipliers)
        local text_scale = Better_Coop_HUD.config.pocket.text.scale
        if edge_multipliers.X == -1 then text_pos.X = text_pos.X - (self.order[0].name:len() * 2.5) end
        Isaac.RenderScaledText(
            self.order[0].name,
            text_pos.X, text_pos.Y,
            text_scale.X, text_scale.Y,
            1, 1, 1, 0.5
        )
    end
end
