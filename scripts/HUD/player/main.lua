local mod = CoopHUDplus

local Health = mod.Health
local Stats = mod.Stats
local Inventory = mod.Inventory
local Item = mod.Item

function mod.Player.IsReal(player_type)
    if player_type == PlayerType.PLAYER_ESAU then return false end
    if player_type == PlayerType.PLAYER_THESOUL_B then return false end
    if player_type == PlayerType.PLAYER_LAZARUS2_B then return false end
    return true
end

function mod.Player.GetItemOpacity(player_entity, player_type)
    -- Vector(ACTIVE, POCKET)
    if player_type ~= PlayerType.PLAYER_JACOB and player_type ~= PlayerType.PLAYER_ESAU then return Vector(1, 1) end
    if Input.IsActionPressed(ButtonAction.ACTION_DROP, player_entity.ControllerIndex) then
        return Vector(0.25, 1)
    end
    return Vector(1, 0.25)
end

function mod.Player.Render(edge, edge_indexed, edge_multipliers, pColor, player_entity, player_number, pType)
    local opacity = mod.Player.GetItemOpacity(player_entity, pType)
    if player_entity:IsCoopGhost() then goto skip_player end

    for slot = ActiveSlot.SLOT_PRIMARY, ActiveSlot.SLOT_SECONDARY, 1 do
        local item_pos = edge_indexed + (mod.config.active_item[slot].pos * edge_multipliers)

        local barFlip = 1
        if not mod.config.active_item[slot].chargebar.stay_on_right then
            barFlip = barFlip * edge_multipliers.X
        end

        local bar_pos = edge_indexed + (
            mod.config.active_item[slot].chargebar.pos * Vector(barFlip, edge_multipliers.Y)
        )

        Item.Active.Render(
            player_entity, pType,
            player_entity:GetActiveItem(slot), slot,
            item_pos, bar_pos,
            mod.config.active_item[slot].scale,
            mod.config.active_item[slot].chargebar.display,
            opacity.X
        )
    end

    for slot = Item.Trinket.SLOT.PRIMARY, Item.Trinket.SLOT.SECONDARY, 1 do
        local pos = edge_indexed + (mod.config.trinket[slot].pos * edge_multipliers)
        Item.Trinket.Render(player_entity:GetTrinket(slot), pos, mod.config.trinket[slot].scale)
    end

    Item.Pocket.Render(
        edge_indexed, edge_multipliers,
        player_entity, player_number, pType,
        mod.config.pocket.chargebar.display, opacity.Y
    )

    Health.Render(edge_indexed, edge_multipliers, player_entity, player_number, player_number < 0)

    Inventory.Render(edge_indexed, edge_multipliers, player_entity, player_number, pType)

    ::skip_player::

    Stats.Render(edge, edge_indexed, edge_multipliers, player_entity, player_number, pColor)

    mod.Utils.CreateCallback(mod.Callbacks.POST_PLAYER_RENDER, player_entity, player_number, edge_indexed, edge_multipliers)
end