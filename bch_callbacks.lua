local json = require('json')

local function onGameStart(_, isCont)
    Better_Coop_HUD.players = {}
    Better_Coop_HUD.joining = {}
    Better_Coop_HUD.pills = {
        cache = {},
        known = {},
    }

    -- TODO save and load data for continued games (specifically pills)
    if isCont and Better_Coop_HUD:HasData() then
        local data = json.decode(Better_Coop_HUD:LoadData())
        Better_Coop_HUD.SAVED_PLAYER_DATA = data.player_invs
        Better_Coop_HUD.pills = data.pills
    end
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onGameStart)

local function onGameExit(_, shouldSave)
    if not shouldSave then return end

    local data = {
        player_invs = {},
        pills = Better_Coop_HUD.pills,
    }

    for i = 0, #Better_Coop_HUD.players, 1 do
        local p = Better_Coop_HUD.players[i]
        if p then
            data.player_invs[p.player_entity.ControllerIndex] = p.inventory.inv
        end
    end

    local jsonString = json.encode(data)
    Better_Coop_HUD:SaveData(jsonString)
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, onGameExit)


local function getPill(_, pillEffect, pillColor)
    Better_Coop_HUD.pills.cache[pillColor] = pillEffect
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, getPill)


local function usePill(_, pillEffect, entityPlayer, useFlags)
    Better_Coop_HUD.pills.known[pillEffect] = true
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_USE_PILL, usePill)


local function getPlayerExists(idx)
    for i = 0, #Better_Coop_HUD.players, 1 do
        if Better_Coop_HUD.players[i].player_entity.ControllerIndex == idx then
            return true
        end
    end
    return false
end
local function getJoining(idx)
    for i = 1, #Better_Coop_HUD.joining, 1 do
        if Better_Coop_HUD.joining[i].controller_index == idx then
            Better_Coop_HUD.joining[i].idx = i
            return Better_Coop_HUD.joining[i]
        end
    end
    return nil
end


local function initNewPlayer(_)
    local game = Game()
    local level = game:GetLevel()
    local room = game:GetRoom()

    if game:IsPaused() then return end

    if level:GetAbsoluteStage() ~= LevelStage.STAGE1_1 then return end
    if level:GetCurrentRoomIndex() ~= level:GetStartingRoomIndex() then return end
    if not room:IsFirstVisit() then return end

    for i = 0, 4 +1, 1 do
        if Input.IsActionTriggered(ButtonAction.ACTION_JOINMULTIPLAYER, i) then
            if getPlayerExists(i) or getJoining(i) then goto skip_init end

            table.insert(Better_Coop_HUD.joining, {
                idx = nil,
                controller_index = i,
                currently_selected = 0,
                number = #Better_Coop_HUD.players + #Better_Coop_HUD.joining + 1
            })
            ::skip_init::
        end
    end
end
local function selectCharacter(_)
    if Game():IsPaused() then return end

    for i = 0, 4 +1, 1 do
        local joining = getJoining(i)
        if not joining then goto skip_select end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENULEFT, i) then
        end
        if Input.IsActionTriggered(ButtonAction.ACTION_MENURIGHT, i) then
        end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENUBACK, i) then
            table.remove(Better_Coop_HUD.joining, joining.idx)
        end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENUCONFIRM, i) then
            table.remove(Better_Coop_HUD.joining, joining.idx)
        end

        ::skip_select::
    end
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_INPUT_ACTION, initNewPlayer)
Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, selectCharacter)


-- requires Repentogon
local function getPlayerFromEntity(player)
    local idx = player.ControllerIndex
    for i = 0, #Better_Coop_HUD.players, 1 do
        if Better_Coop_HUD.players[i] and Better_Coop_HUD.players[i].player_entity.ControllerIndex == idx then
            return Better_Coop_HUD.players[i]
        end
    end
    return nil
end
local function addCollectible(_ ,type, charge, first_time, slot, vardata, player)
    local item = Isaac.GetItemConfig():GetCollectible(type)
    if item.Type == ItemType.ITEM_ACTIVE or item.Type == ItemType.ITEM_TRINKET then return end

    local ignored_ids = {
        [CollectibleType.COLLECTIBLE_BIRTHRIGHT] = true,
        [CollectibleType.COLLECTIBLE_POLAROID] = true,
        [CollectibleType.COLLECTIBLE_NEGATIVE] = true,
    }
    if ignored_ids[item.ID] then return end

    local p = getPlayerFromEntity(player)
    if not p then return end

    p.inventory:addCollectible(item)
end
local function shiftCollectibles(_, entityPlayer, _)
    if Game():IsPaused() then return end

    if Input.IsActionTriggered(ButtonAction.ACTION_DROP, entityPlayer.ControllerIndex) then
        local p = getPlayerFromEntity(entityPlayer)
        if p then p.inventory:shiftCollectibles() end
    end
end
Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, addCollectible)
Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, shiftCollectibles, 0)

