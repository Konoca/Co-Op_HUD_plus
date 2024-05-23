local mod = CoopHUDplus

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

function mod.Player.Render(edge, edge_indexed, edge_multipliers, pColor, player_entity, player_number, pType, is_twin)
    local opacity = mod.Player.GetItemOpacity(player_entity, pType)
    if player_entity:IsCoopGhost() then goto skip_player end

    -- active item

    -- trinket

    -- pocket items

    -- health
    mod.Health.Render(edge_indexed, edge_multipliers, player_entity, player_number, is_twin)

    -- inventory

    ::skip_player::

    -- stats

    -- misc

    mod.Utils.CreateCallback(mod.Callbacks.POST_PLAYER_RENDER, player_entity, edge_indexed, edge_multipliers)

end