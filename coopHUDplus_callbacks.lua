local json = require('json')

function CoopHUDplus.encodeConfigVectors(config)
    local new_config = {}
    for key, value in pairs(config) do
        if key == nil or value == nil then goto skip_encode end
        if type(value) == 'table' then
            value = CoopHUDplus.encodeConfigVectors(value)
        end
        if type(value) == 'userdata' then
            new_config[key..'X'] = value.X
            new_config[key..'Y'] = value.Y
            goto skip_encode
        end

        new_config[key] = value
        ::skip_encode::
    end
    return new_config
end

function CoopHUDplus.decodeConfigVectors(config)
    local new_config = {}
    for key, value in pairs(config) do
        local num = tonumber(key)
        if key == nil or value == nil then goto skip_decode end

        if type(key) == 'string' and num ~= nil then
            key = num
        end

        if type(value) == 'table' then
            value = CoopHUDplus.decodeConfigVectors(value)
        end

        if type(key) == 'string' and key:sub(-1) == 'Y' then
            goto skip_decode
        end
        if type(key) == 'string' and key:sub(-1) == 'X' then
            key = key:sub(1, -2)
            value = Vector(value, config[key..'Y'])
        end

        new_config[key] = value
        ::skip_decode::
    end
    return new_config
end

local function onGameStart(_, isCont)
    CoopHUDplus.players = {}
    CoopHUDplus.joining = {}
    CoopHUDplus.pills = {
        cache = {},
        known = {},
    }

    if not CoopHUDplus:HasData() then return end
    local data = json.decode(CoopHUDplus:LoadData())

    if data.config then CoopHUDplus.config = CoopHUDplus.decodeConfigVectors(data.config) end

    if isCont then
        CoopHUDplus.SAVED_PLAYER_DATA = data.player_invs
        CoopHUDplus.pills = data.pills
    end
end
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onGameStart)

local function onGameExit(_, shouldSave)
    local data = {}
    data.config = CoopHUDplus.encodeConfigVectors(CoopHUDplus.config)

    if shouldSave then
        data.pills = CoopHUDplus.pills
        data.player_invs = {}
        for i = 0, #CoopHUDplus.players, 1 do
            local p = CoopHUDplus.players[i]
            if p then
                data.player_invs[p.player_entity.ControllerIndex] = p.inventory.inv
            end
        end
    end

    local jsonString = json.encode(data)
    CoopHUDplus:SaveData(jsonString)
end
CoopHUDplus:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, onGameExit)


local function getPill(_, pillEffect, pillColor)
    CoopHUDplus.pills.cache[pillColor] = pillEffect
end
CoopHUDplus:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, getPill)


local function usePill(_, pillEffect, entityPlayer, useFlags)
    CoopHUDplus.pills.known[pillEffect] = true
end
CoopHUDplus:AddCallback(ModCallbacks.MC_USE_PILL, usePill)


local function getPlayerExists(idx)
    for i = 0, #CoopHUDplus.players, 1 do
        if CoopHUDplus.players[i].player_entity.ControllerIndex == idx then
            return true
        end
    end
    return false
end
local function getJoining(idx)
    for i = 1, #CoopHUDplus.joining, 1 do
        if CoopHUDplus.joining[i].controller_index == idx then
            CoopHUDplus.joining[i].idx = i
            return CoopHUDplus.joining[i]
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
    if game.Challenge > 0 then return end

    for i = 0, 4 +1, 1 do
        if Input.IsActionTriggered(ButtonAction.ACTION_JOINMULTIPLAYER, i) then
            if getPlayerExists(i) or getJoining(i) then goto skip_init end

            table.insert(CoopHUDplus.joining, {
                idx = nil,
                controller_index = i,
                currently_selected = 0,
                number = #CoopHUDplus.players + #CoopHUDplus.joining + 1
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
            table.remove(CoopHUDplus.joining, joining.idx)
        end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENUCONFIRM, i) then
            table.remove(CoopHUDplus.joining, joining.idx)
        end

        ::skip_select::
    end
end
CoopHUDplus:AddCallback(ModCallbacks.MC_INPUT_ACTION, initNewPlayer)
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, selectCharacter)


-- requires Repentogon
local function getPlayerFromEntity(player)
    local idx = player.ControllerIndex
    for i = 0, #CoopHUDplus.players, 1 do
        if CoopHUDplus.players[i] and CoopHUDplus.players[i].player_entity.ControllerIndex == idx then
            return CoopHUDplus.players[i]
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
        [CollectibleType.COLLECTIBLE_KEY_PIECE_1] = true,
        [CollectibleType.COLLECTIBLE_KEY_PIECE_2] = true,
        [CollectibleType.COLLECTIBLE_KNIFE_PIECE_1] = true,
        [CollectibleType.COLLECTIBLE_KNIFE_PIECE_2] = true,
        [CollectibleType.COLLECTIBLE_DADS_NOTE] = true,
        [CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE] = true,
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
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, addCollectible)
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, shiftCollectibles, 0)

