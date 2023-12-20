local function onGameStart(_, isCont)
    Better_Coop_HUD.players = {}
    Better_Coop_HUD.pills = {}

    -- TODO save and load data for continued games (specifically pills)
    if isCont then
    end
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onGameStart)


-- local function onPlayerInit(_, player)
--     local p = Better_Coop_HUD.Player.new(player)
--     Better_Coop_HUD.players[p.player_entity.Index] = p
-- end
-- Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, onPlayerInit)


-- local function onPlayerUpdate(_, player)
--     local idx = player.Index
--     local p = Better_Coop_HUD.players[idx]
--     if p then p:update(player) end
--     if not p then onPlayerInit(_, player) end
-- end
-- Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, onPlayerUpdate)
-- Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, onPlayerUpdate)


local function getPill(_, pillEffect, pillColor)
    Better_Coop_HUD.pills[pillColor] = pillEffect
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, getPill)
