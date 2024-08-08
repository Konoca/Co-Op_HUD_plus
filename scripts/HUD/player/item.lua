local mod = CoopHUDplus
local DATA = mod.DATA

local Item = mod.Item
local Active = Item.Active
local ChargeBar = Item.ChargeBar
local Trinket = Item.Trinket
local Pocket = Item.Pocket

local ChargeAnim = mod.PATHS.ANIMATIONS.chargebar
local bov = CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES
local bob = CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL

local ItemSprite = Sprite()
local ChargeSprite = {
    overlay = Sprite(),
    charge = Sprite(),
    bg = Sprite(),
    extra = Sprite(),
    beth = Sprite(),
}

ChargeBar.Map = {
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

function ChargeBar.GetSprite(pType, id, max_charge, scale)
    if id == 0 then return nil end

    if ChargeBar.Map[max_charge] ~= nil then
        ChargeSprite.overlay:Load(ChargeAnim, true)
        ChargeSprite.overlay:SetFrame('BarOverlay'..max_charge, 0)
        ChargeSprite.overlay.Scale = scale
    else
        ChargeSprite.overlay:Load(ChargeAnim, false)
    end

    ChargeSprite.charge:Load(ChargeAnim, true)
    ChargeSprite.charge:SetFrame('BarFull', 0)
    ChargeSprite.charge.Scale = scale

    ChargeSprite.bg:Load(ChargeAnim, true)
    ChargeSprite.bg:SetFrame('BarEmpty', 0)
    ChargeSprite.bg.Scale = scale

    local extra_color = Color(1, 1, 1, 1, 0, 0, 0)
    local beth_color = Color(1, 1, 1, 1, 0, 0, 0)

    extra_color:SetColorize(1.8, 1.8, 0, 1)

    -- Colors taken from coopHUD, credit to Srokks
    beth_color:SetColorize(0.8, 0.9, 1.8, 1)
    if pType == PlayerType.PLAYER_BETHANY_B then
        beth_color:SetColorize(1, 0.2, 0.2, 1)
    end

    ChargeSprite.extra:Load(ChargeAnim, true)
    ChargeSprite.extra:SetFrame('BarFull', 0)
    ChargeSprite.extra.Color = extra_color
    ChargeSprite.extra.Scale = scale

    ChargeSprite.beth:Load(ChargeAnim, true)
    ChargeSprite.beth:SetFrame('BarFull', 0)
    ChargeSprite.beth.Color = beth_color
    ChargeSprite.beth.Scale = scale
end

function ChargeBar.GetCharge(current_charge, max_charge, partial_charge)
    if not current_charge then return Vector(1,1) end

    if current_charge <= 0 and (partial_charge == nil or partial_charge <= 0) then
        return Vector(1, 26)
    end

    if current_charge >= max_charge then
        return Vector(1, 3)
    end

    if ChargeBar.Map[max_charge] == nil then
        return Vector(1, 28 - (current_charge * (24 / max_charge)))
    end

    if partial_charge ~= nil and partial_charge > 0 then
        local init = ChargeBar.Map[max_charge][current_charge]
        local partial = (init - ChargeBar.Map[max_charge][current_charge + 1]) * partial_charge
        return Vector(1, init - partial)
    end

    return Vector(1, ChargeBar.Map[max_charge][current_charge])
end

function ChargeBar.Render(pos, pType, current_charge, max_charge, partial_charge, soul_charge, extra_charge)
    if max_charge == 0 then return end

    ChargeSprite.bg:Render(pos)
    if pType == PlayerType.PLAYER_BETHANY then
        ChargeSprite.beth:Render(pos, ChargeBar.GetCharge(soul_charge + current_charge, max_charge))
    end
    ChargeSprite.charge:Render(pos, ChargeBar.GetCharge(current_charge, max_charge, partial_charge))
    ChargeSprite.extra:Render(pos, ChargeBar.GetCharge(extra_charge, max_charge))
    if ChargeBar.Map[max_charge] ~= nil then ChargeSprite.overlay:Render(pos) end
end

function ChargeBar.RenderPocket(pos, pType, current_charge, max_charge, blood_charge, extra_charge)
    if max_charge == 0 then return end

    ChargeSprite.bg:Render(pos)
    if pType == PlayerType.PLAYER_BETHANY_B then
        ChargeSprite.beth:Render(pos, ChargeBar.GetCharge(blood_charge, max_charge))
    end
    ChargeSprite.charge:Render(pos, ChargeBar.GetCharge(current_charge, max_charge))
    ChargeSprite.extra:Render(pos, ChargeBar.GetCharge(extra_charge, max_charge))
    if ChargeBar.Map[max_charge] ~= nil then ChargeSprite.overlay:Render(pos) end
end


Active.Special = {
    [CollectibleType.COLLECTIBLE_D_INFINITY] = function(_, varData, frame, _)
        local tmpFrame = 0
        if varData & Active.D_INFINITY.D4 == Active.D_INFINITY.D4 then tmpFrame = 2 end
        if varData & Active.D_INFINITY.D6 == Active.D_INFINITY.D6 then tmpFrame = 4 end
        if varData & Active.D_INFINITY.E6 == Active.D_INFINITY.E6 then tmpFrame = 6 end
        if varData & Active.D_INFINITY.D7 == Active.D_INFINITY.D7 then tmpFrame = 8 end
        if varData & Active.D_INFINITY.D8 == Active.D_INFINITY.D8 then tmpFrame = 10 end
        if varData & Active.D_INFINITY.D10 == Active.D_INFINITY.D10 then tmpFrame = 12 end
        if varData & Active.D_INFINITY.D12 == Active.D_INFINITY.D12 then tmpFrame = 14 end
        if varData & Active.D_INFINITY.D20 == Active.D_INFINITY.D20 then tmpFrame = 16 end
        if varData & Active.D_INFINITY.D100 == Active.D_INFINITY.D100 then tmpFrame = 18 end

        return 'DInfinity', mod.PATHS.IMAGES.d_infinity, tmpFrame + frame
    end,
    [CollectibleType.COLLECTIBLE_THE_JAR] = function(player_entity, _, _, _)
        return mod.PATHS.IMAGES.jar, 'Jar', math.ceil(player_entity:GetJarHearts() / 2)
    end,
    [CollectibleType.COLLECTIBLE_JAR_OF_FLIES] = function(player_entity, _, _, _)
        return mod.PATHS.IMAGES.jar_of_flies, 'Jar', player_entity:GetJarFlies()
    end,
    [CollectibleType.COLLECTIBLE_JAR_OF_WISPS] = function(_, varData, frame, _)
        return mod.PATHS.IMAGES.jar_of_wisps, 'WispJar', (varData - 1) + (15 * frame)
    end,
    [CollectibleType.COLLECTIBLE_EVERYTHING_JAR] = function(_, varData, frame, current_charge)
        return mod.PATHS.IMAGES.everything_jar, 'EverythingJar', current_charge + 1
    end,
    [CollectibleType.COLLECTIBLE_MAMA_MEGA] = function(player_entity, varData, frame, _)
        if player_entity:HasGoldenBomb() then frame = 1 + frame end
        return mod.PATHS.IMAGES.mama_mega, 'EverythingJar', frame
    end,
    [CollectibleType.COLLECTIBLE_SMELTER] = function(_, _, frame, _)
        return mod.PATHS.IMAGES.smelter, 'DInfinity', 3 * frame
    end,
    [CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS] = function(_, varData, _, _)
        return mod.PATHS.IMAGES.glowing_hour_glass, 'SoulUrn', (3 - varData) + 1
    end,
    [CollectibleType.COLLECTIBLE_URN_OF_SOULS] = function(player_entity, _, _, _)
        return mod.PATHS.IMAGES.urn_of_souls, 'SoulUrn', (
            (21 * player_entity:GetEffects():GetCollectibleEffectNum(640))
            + player_entity:GetUrnSouls() + 1
        )
    end,
}

function Active.GetBook(player_entity, id)
    local hasVirtues = player_entity:HasCollectible(bov) and id ~= bov
    local hasBelial = player_entity:HasCollectible(bob) and id ~= bob

    if hasVirtues and hasBelial then return mod.PATHS.IMAGES.virtues_belial end
    if hasVirtues then return mod.PATHS.IMAGES.virtues end
    if hasBelial then return mod.PATHS.IMAGES.belial end
    return nil
end

function Active.GetSprite(player_entity, desc, id, slot, current_charge, soul_charge, max_charge, book)
    local animation = 'Idle'
    local frame = 0
    if current_charge + soul_charge >= max_charge and max_charge > 0 then frame = 1 end

    local path = Isaac.GetItemConfig():GetCollectible(id).GfxFileName

    local special_active = Active.Special[id]
    if special_active then
        local varData = desc.VarData
        animation, path, frame = special_active(player_entity, varData, frame, current_charge)
    end

    ItemSprite:Load(mod.PATHS.ANIMATIONS.active_item, false)
    ItemSprite:ReplaceSpritesheet(0, path)
    ItemSprite:ReplaceSpritesheet(1, path)
    ItemSprite:ReplaceSpritesheet(2, path)

    if book and slot == ActiveSlot.SLOT_PRIMARY then
        ItemSprite:ReplaceSpritesheet(3, book)
        ItemSprite:ReplaceSpritesheet(4, book)
        if mod.config.active_item.book_charge_outline then ItemSprite:ReplaceSpritesheet(5, book) end
    end

    ItemSprite:SetFrame(animation, frame)
    ItemSprite:LoadGraphics()
end

function Active.Render(player_entity, pType, id, slot, item_pos, bar_pos, scale, display_charge, opacity)
    if id == 0 then return nil end

    ItemSprite.Scale = scale

    local color = Color(1, 1, 1, opacity)
    ItemSprite.Color = color

    local book = Active.GetBook(player_entity, id)
    local desc = player_entity:GetActiveItemDesc(slot)

    if book and slot == ActiveSlot.SLOT_PRIMARY then
        item_pos = item_pos + mod.config.active_item.book_correction_offset
    end

    local current_charge = player_entity:GetActiveCharge(slot)
    local max_charge = player_entity:GetActiveMaxCharge(slot)
    local soul_charge = player_entity:GetSoulCharge()

    Active.GetSprite(player_entity, desc, id, slot, current_charge, soul_charge, max_charge, book)

    ItemSprite:Render(item_pos)
    if display_charge then
        -- ChargeSprite.bg.Scale = scale
        -- ChargeSprite.beth.Scale = scale
        -- ChargeSprite.charge.Scale = scale
        -- ChargeSprite.extra.Scale = scale
        -- ChargeSprite.overlay.Scale = scale

        ChargeSprite.bg.Color = color
        ChargeSprite.beth.Color = color
        ChargeSprite.charge.Color = color
        ChargeSprite.extra.Color = color
        ChargeSprite.overlay.Color = color

        local extra_charge = player_entity:GetBatteryCharge(slot)
        local partial_charge = desc.PartialCharge

        ChargeBar.GetSprite(pType, id, max_charge, scale)
        ChargeBar.Render(bar_pos, pType, current_charge, max_charge, partial_charge, soul_charge, extra_charge)
    end
end


function Trinket.Render(id, pos, scale)
    if id == TrinketType.TRINKET_NULL then return end

    local path = Isaac.GetItemConfig():GetTrinket(id).GfxFileName

    if id & TrinketType.TRINKET_GOLDEN_FLAG > 0 then
        ItemSprite:SetRenderFlags(AnimRenderFlags.GOLDEN)
    end

    ItemSprite:Load(mod.PATHS.ANIMATIONS.trinket, false)
    ItemSprite:ReplaceSpritesheet(1, path)
    ItemSprite:LoadGraphics()
	ItemSprite:SetFrame('Idle', 0)

    ItemSprite.Scale = scale
    ItemSprite:Render(pos)

    ItemSprite:SetRenderFlags(0)
end


function Pocket.Getname(item_config)
    if not item_config then return '???' end

    local name = item_config.Name
    if name:sub(1, 1) ~= '#' then return name end

    name = name:sub(2, -5)
    name = name:gsub('_', ' ')
    name = name:lower():gsub('%f[%a].', string.upper)
    return name
    -- return XMLData.GetEntryById(XMLNode.ITEM, item_config.ID).name
end

function Pocket.GetItem(player_entity, slot)
    local id, type, item_config, name = nil, Pocket.TYPE.NONE, nil, nil
    -- Is item a card? (runes are labeled as cards)
    if player_entity:GetCard(slot) > 0 then
        id = player_entity:GetCard(slot)
        type = Pocket.TYPE.CARD
        item_config = Isaac.GetItemConfig():GetCard(id)

        name = Pocket.Getname(item_config)
    end

    -- Is item a pill?
    if player_entity:GetPill(slot) > 0 then
        id = player_entity:GetPill(slot)
        type = Pocket.TYPE.PILL

        -- convert horse pill ID and golden pill ID to match anm2
        if id > 2048 then
            id = id - 2048 + 16
        end
        if id == 14 then id = 15 end

        -- golden pills should always be ???
        if id == 15 or id == 30 then
            return id, type, mod.PILL[PillEffect.PILLEFFECT_NULL]
        end

        local effectID = DATA.PILLS.cache[id % 16]
        if not effectID then effectID = PillEffect.PILLEFFECT_NULL end

        item_config = Isaac.GetItemConfig():GetPillEffect(effectID)

        local isPillKnown = DATA.PILLS.known[effectID]
        local pillName = mod.PILL[effectID]

        name = isPillKnown and pillName or mod.PILL[PillEffect.PILLEFFECT_NULL]
    end

    return id, type, name
end

function Pocket.GetItems(player_entity, items)
    for slot = Pocket.SLOT.PRIMARY, Pocket.SLOT.QUATERNARY, 1 do
        local id, type, name = Pocket.GetItem(player_entity, slot)

        items[slot] = {
            ID = id,
            Type = type,
            Name = name,
            Slot = slot,
        }
    end
end

function Pocket.GetActives(player_entity, actives)
    for slot = Pocket.SLOT.PERMA, Pocket.SLOT.SINGLE, 1 do
        local id, type, item_config, name = nil, Pocket.TYPE.NONE, nil, nil
        local current_charge, max_charge, blood_charge, extra_charge = nil, nil, nil, nil
        if player_entity:GetActiveItem(slot + 1) > 0 then
            id = player_entity:GetActiveItem(slot + 1)
            type = Pocket.TYPE.ACTIVE
            item_config = Isaac.GetItemConfig():GetCollectible(id)

            current_charge = player_entity:GetActiveCharge(slot + 1)
            max_charge = player_entity:GetActiveMaxCharge(slot + 1)
            blood_charge = player_entity:GetBloodCharge() + current_charge
            extra_charge = player_entity:GetBatteryCharge(slot + 1)

            name = Pocket.Getname(item_config)
        end
        actives[slot] = {
            ID = id,
            Type = type,
            Name = name,
            Slot = slot,
            Charge = {
                Current = current_charge,
                Max = max_charge,
                Blood = blood_charge,
                Extra = extra_charge,
            },
        }
    end
end

function Pocket.GetTotal(items, actives)
    local total = 0
    for i = Pocket.SLOT.PRIMARY, Pocket.SLOT.QUATERNARY, 1 do
        if items[i].Type ~= Pocket.TYPE.NONE then
            total = total + 1
        end
    end
    for i = Pocket.SLOT.PERMA, Pocket.SLOT.SINGLE, 1 do
        if actives[i].Type ~= Pocket.TYPE.NONE then
            total = total + 1
        end
    end
    return total
end

function Pocket.InitOrder(player_entity)
    local order = {}
    local actives = {}

    Pocket.GetItems(player_entity, order)
    Pocket.GetActives(player_entity, actives)

    for slot = Pocket.SLOT.PRIMARY, Pocket.SLOT.QUATERNARY, 1 do
        if order[slot].Type == Pocket.TYPE.NONE then
            actives[ActiveSlot.SLOT_POCKET].Slot = slot
            order[slot] = actives[ActiveSlot.SLOT_POCKET]
            break
        end
    end

    return order, actives
end

function Pocket.GetOrder(player_entity, player_number)
    -- TODO issues happen when you get a dice from dice bag 2 rooms in a row
    -- TODO issues happen when only have pocket active and dice from dice bag

    local oldActives = DATA.PLAYERS[player_number].Pockets.Actives
    if oldActives == nil or #oldActives == 0 then
        return Pocket.InitOrder(player_entity)
    end

    local order = {}
    local actives = {}

    Pocket.GetItems(player_entity, order)
    Pocket.GetActives(player_entity, actives)

    local hasPermanent = actives[Pocket.SLOT.PERMA].Type == Pocket.TYPE.ACTIVE
    local hasSingleUse = actives[Pocket.SLOT.SINGLE].Type == Pocket.TYPE.ACTIVE

    local hadSingleUse = oldActives[Pocket.SLOT.SINGLE].Type == Pocket.TYPE.ACTIVE
    local singleUseDone = not hasSingleUse

    if not hasPermanent and not hasSingleUse then
        return order, actives
    end

    local newSingleUse = hadSingleUse and hasSingleUse and actives[Pocket.SLOT.SINGLE].ID ~= oldActives[Pocket.SLOT.SINGLE].ID

    if ((not hadSingleUse and hasSingleUse) or newSingleUse) and order[Pocket.SLOT.PERMA].type == Pocket.TYPE.NONE then
        actives[Pocket.SLOT.SINGLE].Slot = Pocket.SLOT.PRIMARY
        order[Pocket.SLOT.PRIMARY] = actives[Pocket.SLOT.SINGLE]
        singleUseDone = true
    end

    if hasPermanent and singleUseDone then
        for slot = 0, #order, 1 do
            if order[slot].Type == Pocket.TYPE.NONE then
                actives[Pocket.SLOT.PERMA].Slot = slot
                order[slot] = actives[Pocket.SLOT.PERMA]
                break
            end
        end
    end

    if singleUseDone then
        return order, actives
    end

    local zeros = {}
    local total = Pocket.GetTotal(order, actives)
    for i = Pocket.SLOT.PRIMARY, total - 1 do
        if order[i].Type == Pocket.TYPE.NONE then
            table.insert(zeros, i)
        end
    end

    local oldPermaSlot = oldActives[Pocket.SLOT.PERMA].Slot
    local oldSingleUseSlot = oldActives[Pocket.SLOT.SINGLE].Slot
    local isPermaFirst = oldPermaSlot < oldSingleUseSlot
    local flipPermaOrder = zeros[Pocket.SLOT.TERTIARY] == total - 1

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

        order[newPermaSlot] = actives[Pocket.SLOT.PERMA]
        actives[Pocket.SLOT.PERMA].Slot = newPermaSlot

        order[newSingleUseSlot] = actives[Pocket.SLOT.SINGLE]
        actives[Pocket.SLOT.SINGLE].Slot = newSingleUseSlot

        return order, actives
    end

    if hasPermanent then
        order[zeros[Pocket.SLOT.SECONDARY]] = actives[Pocket.SLOT.PERMA]
        actives[Pocket.SLOT.PERMA].Slot = zeros[Pocket.SLOT.SECONDARY]

        return order, actives
    end

    if hasSingleUse then
        order[zeros[Pocket.SLOT.SECONDARY]] = actives[Pocket.SLOT.SINGLE]
        actives[Pocket.SLOT.SINGLE].Slot = zeros[Pocket.SLOT.SECONDARY]

        return order, actives
    end

    return order, actives
end

function Pocket.GetSprite(item, pType)
    if item.Type == Pocket.TYPE.NONE then return end

    if item.Type == Pocket.TYPE.CARD or item.Type == Pocket.TYPE.PILL then
        ItemSprite:Load(mod.PATHS.ANIMATIONS.pocket_items, false)

        local animation_map = {
            [Pocket.TYPE.PILL] = 'pills',
            [Pocket.TYPE.CARD] = 'cards',
        }
        local animation = animation_map[item.Type]

        ItemSprite:ReplaceSpritesheet(0, 'gfx/ui/ui_cardspills.png')
        ItemSprite:ReplaceSpritesheet(1, 'gfx/ui/ui_cardfronts.png')
        ItemSprite:LoadGraphics()

        ItemSprite:SetFrame(animation, item.ID)
        return
    end

    local path = Isaac.GetItemConfig():GetCollectible(item.ID).GfxFileName

    ItemSprite:Load(mod.PATHS.ANIMATIONS.active_item, false)

    if item.ID == CollectibleType.COLLECTIBLE_FLIP and pType == PlayerType.PLAYER_LAZARUS2_B then
        path = mod.PATHS.IMAGES.flip
    end

    ItemSprite:ReplaceSpritesheet(0, path)
    ItemSprite:ReplaceSpritesheet(1, path)
    ItemSprite:ReplaceSpritesheet(2, path)

    local frame = 0
    if item.Charge.Current >= item.Charge.Max and item.Charge.Max > 0 then frame = 1 end

    ItemSprite:SetFrame('Idle', frame)
    ItemSprite:LoadGraphics()
end

function Pocket.Render(edge_indexed, edge_multipliers, player_entity, player_number, pType, display_charge, opacity)
    local order, actives = Pocket.GetOrder(player_entity, player_number)
    DATA.PLAYERS[player_number].Pockets.Actives = actives
    for i = Pocket.SLOT.PRIMARY, Pocket.SLOT.QUATERNARY, 1 do
        if not order[i] then goto skip_pocket end
        if order[i].Type == Pocket.TYPE.NONE then goto skip_pocket end

        local item_pos = edge_indexed + (mod.config.pocket[i].pos * edge_multipliers)

        local bar_flip = 1
        if not mod.config.pocket.chargebar.stay_on_right then
            bar_flip = bar_flip * edge_multipliers.X
        end
        local bar_pos = item_pos + (mod.config.pocket.chargebar.pos * Vector(bar_flip, edge_multipliers.Y))

        Pocket.GetSprite(order[i], pType)

        ItemSprite.Scale = mod.config.pocket[i].scale
        ItemSprite.Color = Color(1, 1, 1, opacity)
        ItemSprite:Render(item_pos)

        if order[i].Type ~= Pocket.TYPE.ACTIVE then goto skip_pocket end
        if order[i].Slot ~= Pocket.SLOT.PRIMARY then goto skip_pocket end
        if not display_charge then goto skip_pocket end

        if order[i].Charge.Current and order[i].Charge.Max and order[i].Charge.Max > 0 then
            ChargeBar.GetSprite(pType, order[i].ID, order[i].Charge.Max, mod.config.pocket.chargebar.scale)

            ChargeBar.RenderPocket(
                bar_pos,
                pType,
                order[i].Charge.Current,
                order[i].Charge.Max,
                order[i].Charge.Blood,
                order[i].Charge.Extra
            )
        end

        ::skip_pocket::
    end

    if order[Pocket.SLOT.PRIMARY].Type ~= Pocket.TYPE.NONE and mod.config.pocket.text.display then
        local text_pos = edge_indexed + (mod.config.pocket.text.pos * edge_multipliers)
        local text_scale = mod.config.pocket.text.scale
        if edge_multipliers.X == -1 then text_pos.X = text_pos.X - (order[0].Name:len() * 2.5) end
        if edge_multipliers.Y == -1 then text_pos.Y = text_pos.Y - mod.config.pocket.text.pos.Y / 3 end

        DATA.FONTS.pocket_items:DrawStringScaled(
            order[0].Name,
            text_pos.X, text_pos.Y,
            text_scale.X, text_scale.Y,
            KColor(1, 1, 1, 0.5 * opacity),
            0, true
        )
    end
end
