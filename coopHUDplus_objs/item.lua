local chargeMap = {
        [2] = {
            [0] = 26,
            [1] = 14,   -- 1/2
        },
        [3] = {
            [0] = 26,
            [1] = 19,   -- 1/3
            [2] = 10,   -- 2/3
        },
        [4] = {
            [0] = 26,
            [1] = 20,   -- 1/4
            [2] = 14,   -- 1/2
            [3] = 8,    -- 3/4
        },
        [5] = {
            [0] = 26,
            [1] = 20,
            [2] = 15,
            [3] = 11,
            [4] = 6,
        },
        [6] = {
            [0] = 26,
            [1] = 22,   -- 1/6
            [2] = 19,   -- 1/3
            [3] = 14,   -- 1/2
            [4] = 10,   -- 2/3
            [5] = 7,    -- 5/6
        },
        [8] = {
            [0] = 26,
            [1] = 23,
            [2] = 20,    -- 1/4
            [3] = 17,
            [4] = 14,    -- 1/2
            [5] = 11,
            [6] = 8,     -- 3/4
            [7] = 5,
        },
        [12] = {
            [0] = 26,
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

local function getChargeBar(pType, id, max_charge, scale)
    if id == 0 then return nil end

    local sprite = {
        overlay = Sprite(),
        charge = Sprite(),
        bg = Sprite(),
        extra = Sprite(),
        beth = Sprite(),
    }

    if chargeMap[max_charge] ~= nil then
        sprite.overlay:Load(CoopHUDplus.PATHS.ANIMATIONS.chargebar, true)
        sprite.overlay:SetFrame('BarOverlay'..max_charge, 0)
        sprite.overlay.Scale = scale
    end

    sprite.charge:Load(CoopHUDplus.PATHS.ANIMATIONS.chargebar, true)
    sprite.charge:SetFrame('BarFull', 0)
    sprite.charge.Scale = scale

    sprite.bg:Load(CoopHUDplus.PATHS.ANIMATIONS.chargebar, true)
    sprite.bg:SetFrame('BarEmpty', 0)
    sprite.bg.Scale = scale

    local extra_color = Color(1, 1, 1, 1, 0, 0, 0)
    local beth_color = Color(1, 1, 1, 1, 0, 0, 0)

    extra_color:SetColorize(1.8, 1.8, 0, 1)

    -- Colors taken from coopHUD, credit to Srokks
    beth_color:SetColorize(0.8, 0.9, 1.8, 1)
    if pType == PlayerType.PLAYER_BETHANY_B then
        beth_color:SetColorize(1, 0.2, 0.2, 1)
    end

    sprite.extra:Load(CoopHUDplus.PATHS.ANIMATIONS.chargebar, true)
    sprite.extra:SetFrame('BarFull', 0)
    sprite.extra.Color = extra_color
    sprite.extra.Scale = scale

    sprite.beth:Load(CoopHUDplus.PATHS.ANIMATIONS.chargebar, true)
    sprite.beth:SetFrame('BarFull', 0)
    sprite.beth.Color = beth_color
    sprite.beth.Scale = scale

    return sprite
end

local function getChargeBarCharge(current_charge, max_charge, partial_charge)
    if not current_charge then return Vector(1,1) end

    if current_charge <= 0 and (partial_charge == nil or partial_charge <= 0) then
        return Vector(1, 26)
    end

    if current_charge >= max_charge then
        return Vector(1, 3)
    end

    if chargeMap[max_charge] == nil then
        return Vector(1, 28 - (current_charge * (24 / max_charge)))
    end

    if partial_charge ~= nil and partial_charge > 0 then
        local init = chargeMap[max_charge][current_charge]
        local partial = (init - chargeMap[max_charge][current_charge + 1]) * partial_charge
        return Vector(1, init - partial)
    end

    return Vector(1, chargeMap[max_charge][current_charge])
end

-- Active Item
function CoopHUDplus.ActiveItem.new(entity, slot)
    local self = setmetatable({}, CoopHUDplus.ActiveItem)

    self.slot = slot
    self.entity = entity

    self.id = entity:GetActiveItem(slot)
    self.desc = entity:GetActiveItemDesc()
    self.current_charge = entity:GetActiveCharge(slot)

    if Isaac.GetItemConfig():GetCollectible(self.id) == nil then
        return nil
    end

    -- self.max_charge = Isaac.GetItemConfig():GetCollectible(self.id).MaxCharges
    self.max_charge = entity:GetActiveMaxCharge(slot)
    self.extra_charge = entity:GetBatteryCharge(slot)
    self.soul_charge = entity:GetSoulCharge()
    -- self.blood_charge = entity:GetBloodCharge()

    self.sprite = self:getSprite()
    -- self.chargeBar = self:getChargeBar()
    self.chargeBar = getChargeBar(self.entity:GetPlayerType(), self.id, self.max_charge, CoopHUDplus.config.active_item[slot].scale)
    return self
end

function CoopHUDplus.ActiveItem:getSprite()
    if self.id == 0 then return nil end

    local animation = 'Idle'
    local frame = 0
    if self.current_charge + self.soul_charge >= self.max_charge and self.max_charge > 0 then frame = 1 end

    local sprite = Sprite()
    local path = Isaac.GetItemConfig():GetCollectible(self.id).GfxFileName

    animation, path, frame = self:getSpecialActives(animation, path, frame)

    sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.active_item, false)
    sprite:ReplaceSpritesheet(0, path)
    sprite:ReplaceSpritesheet(1, path)
    sprite:ReplaceSpritesheet(2, path)

    local bookpath = self:getBookPath()
    if bookpath and self.slot == ActiveSlot.SLOT_PRIMARY then
        sprite:ReplaceSpritesheet(3, bookpath)
        sprite:ReplaceSpritesheet(4, bookpath)
        if CoopHUDplus.config.active_item.book_charge_outline then sprite:ReplaceSpritesheet(5, bookpath) end
    end

    sprite:SetFrame(animation, frame)
    sprite:LoadGraphics()
    return sprite
end

function CoopHUDplus.ActiveItem:getSpecialActives(animation, path, frame)
    if self.id == CollectibleType.COLLECTIBLE_D_INFINITY then
        animation = 'DInfinity'
        path = CoopHUDplus.PATHS.IMAGES.d_infinity

        local varData = self.desc.VarData
        local tmpFrame = 0
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D4 == CoopHUDplus.ActiveItem.D_INFINITY.D4 then tmpFrame = 2 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D6 == CoopHUDplus.ActiveItem.D_INFINITY.D6 then tmpFrame = 4 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.E6 == CoopHUDplus.ActiveItem.D_INFINITY.E6 then tmpFrame = 6 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D7 == CoopHUDplus.ActiveItem.D_INFINITY.D7 then tmpFrame = 8 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D8 == CoopHUDplus.ActiveItem.D_INFINITY.D8 then tmpFrame = 10 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D10 == CoopHUDplus.ActiveItem.D_INFINITY.D10 then tmpFrame = 12 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D12 == CoopHUDplus.ActiveItem.D_INFINITY.D12 then tmpFrame = 14 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D20 == CoopHUDplus.ActiveItem.D_INFINITY.D20 then tmpFrame = 16 end
        if varData & CoopHUDplus.ActiveItem.D_INFINITY.D100 == CoopHUDplus.ActiveItem.D_INFINITY.D100 then tmpFrame = 18 end

        frame = tmpFrame + frame
    end

    if self.id == CollectibleType.COLLECTIBLE_THE_JAR then
        path = CoopHUDplus.PATHS.IMAGES.jar
        animation = 'Jar'
        frame = math.ceil(self.entity:GetJarHearts() / 2)
    end

    if self.id == CollectibleType.COLLECTIBLE_JAR_OF_FLIES then
        path = CoopHUDplus.PATHS.IMAGES.jar_of_flies
        animation = 'Jar'
        frame = self.entity:GetJarFlies()
    end

    if self.id == CollectibleType.COLLECTIBLE_JAR_OF_WISPS then
        path = CoopHUDplus.PATHS.IMAGES.jar_of_wisps
        animation = 'WispJar'
        frame = (self.desc.VarData - 1) + (15 * frame)
    end

    if self.id == CollectibleType.COLLECTIBLE_EVERYTHING_JAR then
        path = CoopHUDplus.PATHS.IMAGES.everything_jar
        animation = 'EverythingJar'
        frame = self.current_charge + 1
    end

    if self.id == CollectibleType.COLLECTIBLE_MAMA_MEGA then
        path = CoopHUDplus.PATHS.IMAGES.mama_mega
        animation = 'EverythingJar'
        if self.entity:HasGoldenBomb() then frame = 1 + frame end
    end

    if self.id == CollectibleType.COLLECTIBLE_SMELTER then
        path = CoopHUDplus.PATHS.IMAGES.smelter
        animation = 'DInfinity'
        frame = 3 * frame
    end

    if self.id == CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS then
        path = CoopHUDplus.PATHS.IMAGES.glowing_hour_glass
        animation = 'SoulUrn'
        frame = (3 - self.desc.VarData) + 1
    end

    if self.id == CollectibleType.COLLECTIBLE_URN_OF_SOULS then
        path = CoopHUDplus.PATHS.IMAGES.urn_of_souls
        animation = 'SoulUrn'
        frame = (21 * self.entity:GetEffects():GetCollectibleEffectNum(640)) + self.entity:GetUrnSouls() + 1
    end

    return animation, path, frame
end

function CoopHUDplus.ActiveItem:getBookSprite()
    if self.slot ~= ActiveSlot.SLOT_PRIMARY then return nil end

    local bookpath = self:getBookPath()
    if not bookpath then return nil end

    local sprite = Sprite()
    sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.book, false)

    sprite:ReplaceSpritesheet(1, bookpath)

    sprite:SetFrame('Idle', 0)
    sprite:LoadGraphics()
    return Sprite()
end

function CoopHUDplus.ActiveItem:getBookPath()
    local bov = CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES
    local bob = CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL

    local hasVirtues = self.entity:HasCollectible(bov) and self.id ~= bov
    local hasBelial = self.entity:HasCollectible(bob) and self.id ~= bob

    if hasVirtues and hasBelial then return CoopHUDplus.PATHS.IMAGES.virtues_belial end
    if hasVirtues then return CoopHUDplus.PATHS.IMAGES.virtues end
    if hasBelial then return CoopHUDplus.PATHS.IMAGES.belial end
    return nil
end

function CoopHUDplus.ActiveItem:render(item_pos_vec, bar_pos_vec, scale, display_charge, opacity)
    self.sprite.Scale = scale
    self.chargeBar.bg.Scale = scale
    self.chargeBar.beth.Scale = scale
    self.chargeBar.charge.Scale = scale
    self.chargeBar.extra.Scale = scale
    self.chargeBar.overlay.Scale = scale

    local color = Color(1, 1, 1, opacity)
    self.sprite.Color = color
    self.chargeBar.bg.Color = color
    self.chargeBar.beth.Color = color
    self.chargeBar.charge.Color = color
    self.chargeBar.extra.Color = color
    self.chargeBar.overlay.Color = color

    if self:getBookPath() and self.slot == ActiveSlot.SLOT_PRIMARY then
        item_pos_vec = Vector(
            item_pos_vec.X + CoopHUDplus.config.active_item.book_correction_offset.X,
            item_pos_vec.Y + CoopHUDplus.config.active_item.book_correction_offset.Y
        )
    end
    self.sprite:Render(item_pos_vec)

    if self.current_charge and self.max_charge and self.max_charge > 0 and display_charge then
        local partial_charge = self.desc.PartialCharge
        self.chargeBar.bg:Render(bar_pos_vec)
        if self.entity:GetPlayerType() == PlayerType.PLAYER_BETHANY then
            self.chargeBar.beth:Render(bar_pos_vec, getChargeBarCharge(self.soul_charge + self.current_charge, self.max_charge))
        end
        self.chargeBar.charge:Render(bar_pos_vec, getChargeBarCharge(self.current_charge, self.max_charge, partial_charge))
        self.chargeBar.extra:Render(bar_pos_vec, getChargeBarCharge(self.extra_charge, self.max_charge))
        if chargeMap[self.max_charge] ~= nil then self.chargeBar.overlay:Render(bar_pos_vec) end
    end
end

-- Trinket
function CoopHUDplus.Trinket.new(entity, slot)
    local self = setmetatable({}, CoopHUDplus.Trinket)

    self.slot = slot
    self.player_entity = entity

    self.id = entity:GetTrinket(slot)
    self.sprite = self:getSprite()

    return self
end

function CoopHUDplus.Trinket:getSprite()
    if self.id == TrinketType.TRINKET_NULL then return nil end

    local sprite = Sprite()
	local path = Isaac.GetItemConfig():GetTrinket(self.id).GfxFileName

	sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.trinket, false)
	sprite:ReplaceSpritesheet(1, path)

	sprite:LoadGraphics()
	sprite:SetFrame('Idle', 0)

	return sprite
end

function CoopHUDplus.Trinket:render(pos_vector, scale)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite:Render(pos_vector)
end

-- Pocket Item (pill, card, rune)
local function getPocketItemName(item_config)
    if not item_config then return '???' end

    local name = item_config.Name
    if name:sub(1, 1) ~= '#' then return name end

    name = name:sub(2, -5)
    name = name:gsub('_', ' ')
    name = name:lower():gsub('%f[%a].', string.upper)
    return name
    -- return XMLData.GetEntryById(XMLNode.ITEM, item_config.ID).name
end

function CoopHUDplus.PocketItem.new(entity, slot)
    local self = setmetatable({}, CoopHUDplus.PocketItem)

    self.id = 0
    self.slot = slot
    self.player_entity = entity
    self.type = CoopHUDplus.PocketItem.TYPE_NONE

    -- Is item a card? (runes are labeled as cards)
    if self.player_entity:GetCard(slot) > 0 then
        self.id = self.player_entity:GetCard(slot)
        self.type = CoopHUDplus.PocketItem.TYPE_CARD
        self.item_config = Isaac.GetItemConfig():GetCard(self.id)

        self.name = getPocketItemName(self.item_config)
    end

    -- Is item a pill?
    if self.player_entity:GetPill(slot) > 0 then
        self.id = self.player_entity:GetPill(slot)
        self.type = CoopHUDplus.PocketItem.TYPE_PILL

        local effectID = CoopHUDplus.pills.cache[self.id]
        if not effectID then effectID = PillEffect.PILLEFFECT_NULL end

        self.item_config = Isaac.GetItemConfig():GetPillEffect(effectID)

        local isPillKnown = CoopHUDplus.pills.known[effectID]
        local pillName = CoopHUDplus.PILL[effectID]

        self.name = isPillKnown and pillName or CoopHUDplus.PILL[PillEffect.PILLEFFECT_NULL]
    end

    self.sprite = self:getSprite()

    return self
end

function CoopHUDplus.PocketItem:getSprite()
    if self.type == CoopHUDplus.PocketItem.TYPE_NONE then return nil end

    local sprite = Sprite()
    sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.pocket_items, false)

    local animation_map = {
        [CoopHUDplus.PocketItem.TYPE_PILL] = 'pills',
        [CoopHUDplus.PocketItem.TYPE_CARD] = 'cards',
    }
    local animation = animation_map[self.type]

    sprite:ReplaceSpritesheet(0, 'gfx/ui/ui_cardspills.png')
    sprite:ReplaceSpritesheet(1, 'gfx/ui/ui_cardfronts.png')
    sprite:LoadGraphics()

    sprite:SetFrame(animation, self.id)
    return sprite
end

function CoopHUDplus.PocketItem:render(pos_vector, _, scale, opacity)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite.Color = Color(1, 1, 1, opacity)
    self.sprite:Render(pos_vector)
end

-- Pocket Active Item (tainted characters)
function CoopHUDplus.PocketActiveItem.new(entity, slot)
    local self = setmetatable({}, CoopHUDplus.PocketActiveItem)
    self.id = 0
    self.slot = slot
    self.type = CoopHUDplus.PocketItem.TYPE_NONE
    self.pType = entity:GetPlayerType()

    if entity:GetActiveItem(slot) > 0 then
        self.id = entity:GetActiveItem(slot)
        self.type = CoopHUDplus.PocketItem.TYPE_ACTIVE
        self.item_config = Isaac.GetItemConfig():GetCollectible(self.id)

        self.name = getPocketItemName(self.item_config)

        self.current_charge = entity:GetActiveCharge(slot)
        -- self.max_charge = Isaac.GetItemConfig():GetCollectible(self.id).MaxCharges
        self.max_charge = entity:GetActiveMaxCharge(slot)
        self.blood_charge = entity:GetBloodCharge() + self.current_charge
        self.extra_charge = entity:GetBatteryCharge(slot)

        self.sprite = self:getSprite()
        self.chargeBar = getChargeBar(self.pType, self.id, self.max_charge, CoopHUDplus.config.pocket.chargebar.scale)
    end

    return self
end

function CoopHUDplus.PocketActiveItem:getSprite()
    if self.id == 0 then return nil end

    local sprite = Sprite()
    local path = Isaac.GetItemConfig():GetCollectible(self.id).GfxFileName

    sprite:Load(CoopHUDplus.PATHS.ANIMATIONS.active_item, false)

    if self.id == CollectibleType.COLLECTIBLE_FLIP and self.pType == PlayerType.PLAYER_LAZARUS2_B then
        path = CoopHUDplus.PATHS.IMAGES.flip
    end

    sprite:ReplaceSpritesheet(0, path)
    sprite:ReplaceSpritesheet(1, path)
    sprite:ReplaceSpritesheet(2, path)

    local frame = 0
    if self.current_charge >= self.max_charge and self.max_charge > 0 then frame = 1 end

    sprite:SetFrame('Idle', frame)
    sprite:LoadGraphics()
    return sprite
end

function CoopHUDplus.PocketActiveItem:render(pos_vector, bar_pos_vec, scale, opacity)
    if not self.sprite then return end

    self.sprite.Scale = scale
    self.sprite.Color = Color(1, 1, 1, opacity)
    self.sprite:Render(pos_vector)

    if self.current_charge and self.max_charge and self.max_charge > 0 and CoopHUDplus.config.pocket.chargebar.display and self.slot == CoopHUDplus.PocketItem.SLOT_PRIMARY then
        self.chargeBar.bg:Render(bar_pos_vec)

        if self.pType == PlayerType.PLAYER_BETHANY_B then self.chargeBar.beth:Render(bar_pos_vec, getChargeBarCharge(self.blood_charge, self.max_charge)) end

        self.chargeBar.charge:Render(bar_pos_vec, getChargeBarCharge(self.current_charge, self.max_charge))
        self.chargeBar.extra:Render(bar_pos_vec, getChargeBarCharge(self.extra_charge, self.max_charge))
        self.chargeBar.overlay:Render(bar_pos_vec)
    end
end

function CoopHUDplus.Pockets.new(player_entity, previous_player)
    local self = setmetatable({}, CoopHUDplus.Pockets)

    self.player_entity = player_entity
    self.previous_player = previous_player

    self.items = {
        [0] = CoopHUDplus.PocketItem.new(player_entity, CoopHUDplus.PocketItem.SLOT_PRIMARY),
        [1] = CoopHUDplus.PocketItem.new(player_entity, CoopHUDplus.PocketItem.SLOT_SECONDARY),
        [2] = CoopHUDplus.PocketItem.new(player_entity, CoopHUDplus.PocketItem.SLOT_TERTIARY),
        [3] = CoopHUDplus.PocketItem.new(player_entity, CoopHUDplus.PocketItem.SLOT_QUATERNARY),
    }

    self.actives = {
        -- permanent (tainted active items)
        [0] = CoopHUDplus.PocketActiveItem.new(player_entity, ActiveSlot.SLOT_POCKET),

        -- single use (ex. dice bag)
        [1] = CoopHUDplus.PocketActiveItem.new(player_entity, ActiveSlot.SLOT_POCKET2),
    }

    self.total_items = self:getTotal()

    if previous_player ~= nil then
        self.order = self:determineOrder()
    else
        self.order = self:initOrder()
    end

    return self
end

function CoopHUDplus.Pockets:getTotal()
    local total = 0
    for i = 0, #self.items, 1 do
        if self.items[i].type ~= CoopHUDplus.PocketItem.TYPE_NONE then
            total = total + 1
        end
    end
    for i = 0, #self.actives, 1 do
        if self.actives[i].type ~= CoopHUDplus.PocketItem.TYPE_NONE then
            total = total + 1
        end
    end
    return total
end

function CoopHUDplus.Pockets:increment_slot(slot)
    local new = slot + 1
    if new >= self.total_items then
        new = 0
    end
    return new
end
function CoopHUDplus.Pockets:decrement_slot(slot)
    local new = slot - 1
    if new <= 0 then
        new = self.total_items - 1
    end
    return new
end

function CoopHUDplus.Pockets:initOrder()
    local order = {}
    for i = 0, #self.items do
        order[i] = self.items[i]
    end

    for i = 0, #order, 1 do
        if order[i].type == CoopHUDplus.PocketItem.TYPE_NONE then
            self.actives[0].slot = i
            order[i] = self.actives[0]
            break
        end
    end

    return order
end

function CoopHUDplus.Pockets:determineOrder()
    -- TODO issues happen when you get a dice from dice bag 2 rooms in a row
    -- TODO issues happen when only have pocket active and dice from dice bag
    if self.previous_player == nil or self.previous_player.pockets == nil then
        return self:initOrder()
    end

    local order = {}
    for i = 0, #self.items do
        order[i] = self.items[i]
    end

    local hasPermanent = self.actives[0].type == CoopHUDplus.PocketItem.TYPE_ACTIVE
    local hasSingleUse = self.actives[1].type == CoopHUDplus.PocketItem.TYPE_ACTIVE

    local hadSingleUse = self.previous_player.pockets.actives[1].type == CoopHUDplus.PocketItem.TYPE_ACTIVE

    local singleUseDone = not hasSingleUse

    if not hasPermanent and not hasSingleUse then
        return order
    end

    local newSingleUse = hadSingleUse and hasSingleUse and self.actives[1].id ~= self.previous_player.pockets.actives[1].id

    if ((not hadSingleUse and hasSingleUse) or newSingleUse) and order[0].type == CoopHUDplus.PocketItem.TYPE_NONE then
        self.actives[1].slot = 0
        order[0] = self.actives[1]
        singleUseDone = true
    end

    if hasPermanent and singleUseDone then
        for i = 0, #order, 1 do
            if order[i].type == CoopHUDplus.PocketItem.TYPE_NONE then
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

function CoopHUDplus.Pockets:render(edge_indexed, edge_multipliers, opacity)
    for i = 0, #self.order, 1 do
        if not self.order[i] then goto skip_pocket end

        local item_pos = edge_indexed + (CoopHUDplus.config.pocket[i].pos * edge_multipliers)

        local bar_flip = 1
        if not CoopHUDplus.config.pocket.chargebar.stay_on_right then
            bar_flip = bar_flip * edge_multipliers.X
        end
        local bar_pos = item_pos + (CoopHUDplus.config.pocket.chargebar.pos * Vector(bar_flip, edge_multipliers.Y))

        self.order[i]:render(item_pos, bar_pos, CoopHUDplus.config.pocket[i].scale, opacity)
        ::skip_pocket::
    end

    if self.order[0].type ~= CoopHUDplus.PocketItem.TYPE_NONE and CoopHUDplus.config.pocket.text.display then
        local text_pos = edge_indexed + (CoopHUDplus.config.pocket.text.pos * edge_multipliers)
        local text_scale = CoopHUDplus.config.pocket.text.scale
        if edge_multipliers.X == -1 then text_pos.X = text_pos.X - (self.order[0].name:len() * 2.5) end
        if edge_multipliers.Y == -1 then text_pos.Y = text_pos.Y - CoopHUDplus.config.pocket.text.pos.Y / 3 end

        local f, _ = Font(CoopHUDplus.PATHS.FONTS[CoopHUDplus.config.fonts.pocket_items])
        f:DrawStringScaled(
            self.order[0].name,
            text_pos.X, text_pos.Y,
            text_scale.X, text_scale.Y,
            KColor(1, 1, 1, 0.5 * opacity),
            0, true
        )
    end
end
