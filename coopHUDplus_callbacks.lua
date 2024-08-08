local json = require('json')

local function onGameStart(_, isCont)
    CoopHUDplus.players = {}
    CoopHUDplus.joining = {}
    CoopHUDplus.pills = {
        cache = {},
        known = {},
    }
    CoopHUDplus.SAVED_PLAYER_DATA = {}

    if not CoopHUDplus:HasData() then return end
    local data = json.decode(CoopHUDplus:LoadData())

    if data.config then
        local savedData = CoopHUDplus.Utils.decodeConfigVectors(data.config)
        if savedData.version ~= nil then
            CoopHUDplus.config = CoopHUDplus.Utils.ensureCompatibility(CoopHUDplus.config, savedData)
            CoopHUDplus.config.version = CoopHUDplus.version
        end
    end

    if isCont then
        CoopHUDplus.SAVED_PLAYER_DATA = data.players
        CoopHUDplus.pills = data.pills
    end
end
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onGameStart)

local function saveGame(saveGameData)
    local data = {}
    data.config = CoopHUDplus.Utils.encodeConfigVectors(CoopHUDplus.config)

    if saveGameData then
        data.pills = CoopHUDplus.pills
        data.players = {}

        for i = 0, #CoopHUDplus.players, 1 do
            local p = CoopHUDplus.players[i]
            if p then
                local idx = p.number
                data.players[idx] = {}
                data.players[idx].inv = p.inventory.inv
                data.players[idx].items = p.items
            end
        end

        if data.pills.cache then
            local lastCache, largestPill = 0, 0
            for k, v in pairs(data.pills.cache) do lastCache, largestPill = k, v end

            for i = 1, lastCache, 1 do if not data.pills.cache[i] then data.pills.cache[i] = false end end
            for i = 1, largestPill, 1 do if not data.pills.known[i] then data.pills.known[i] = false end end
        end
    end

    local jsonString = json.encode(data)
    CoopHUDplus:SaveData(jsonString)
end

local function onGameExit(_, shouldSave)
    saveGame(shouldSave)
end
CoopHUDplus:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, onGameExit)

local function getPill(_, pillEffect, pillColor)
    CoopHUDplus.pills.cache[pillColor] = pillEffect
end
CoopHUDplus:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, getPill)


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

local function newLevel(_)
    local level = Game():GetLevel()
    local name = level:GetName()
    local curse = level:GetCurseName()
    CoopHUDplus.Utils.createStreak(name, curse, curse ~= '')


    if level:GetStage() ~= LevelStage.STAGE1_1 then
        saveGame(true)
    end
end
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, newLevel)


-- requires Repentogon
local function addCollectible(_ ,type, charge, first_time, slot, vardata, player)
    local item = Isaac.GetItemConfig():GetCollectible(type)

    local game = Game()
    local level = game:GetLevel()

    if level:GetAbsoluteStage() == LevelStage.STAGE1_1
        and level:GetCurrentRoomIndex() == level:GetStartingRoomIndex()
        and game:GetRoom():IsFirstVisit() then

        return
    end

    local xmldata = XMLData.GetEntryById(XMLNode.ITEM, type)
    local name = xmldata.name
    local description = xmldata.description
    CoopHUDplus.Utils.createStreak(name, description, false)

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
        [CollectibleType.COLLECTIBLE_DOGMA] = true,
    }
    if ignored_ids[item.ID] then return end

    local p = CoopHUDplus.Utils.getPlayerFromEntity(player)
    if not p then return end

    p.inventory:addCollectible(item)
end
local function shiftCollectibles(_, entityPlayer, _)
    if Game():IsPaused() then return end

    if Input.IsActionTriggered(ButtonAction.ACTION_DROP, entityPlayer.ControllerIndex) then
        local p = CoopHUDplus.Utils.getPlayerFromEntity(entityPlayer)
        if p then p.inventory:shiftCollectibles() end
    end
end
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, addCollectible)
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, shiftCollectibles, 0)


local function customCommands(_, cmd, params)
    print(cmd, params)
    if cmd == CoopHUDplus.cmd_prefix..'reset' then CoopHUDplus.ResetConfig() end
end
CoopHUDplus:AddCallback(ModCallbacks.MC_EXECUTE_CMD, customCommands)


local function usePill(_, pillEffect, entityPlayer, useFlags)
    CoopHUDplus.pills.known[pillEffect] = true

    local xmldata = XMLData.GetEntryById(XMLNode.PILL, pillEffect)
    local name = xmldata.name
    local description = xmldata.description
    CoopHUDplus.Utils.createStreak(name, description, false)
end
CoopHUDplus:AddCallback(ModCallbacks.MC_USE_PILL, usePill)

local function useCard(_, card, entityPlayer, useFlags)
    local xmldata = XMLData.GetEntryById(XMLNode.CARD, card)
    local name = xmldata.name
    local description = xmldata.description
    CoopHUDplus.Utils.createStreak(name, description, false)
end
CoopHUDplus:AddCallback(ModCallbacks.MC_USE_CARD, useCard)

local function pickupTrinket(_, entityPlayer, trinketType, firstTime)
    local xmldata = XMLData.GetEntryById(XMLNode.TRINKET, trinketType)
    local name = xmldata.name
    local description = xmldata.description
    CoopHUDplus.Utils.createStreak(name, description, false)
end
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_TRIGGER_TRINKET_ADDED, pickupTrinket)



local function addCollectibleToItems(_ ,type, _, _, _, _, player)
    local p = CoopHUDplus.Utils.getPlayerFromEntity(player)
    if not p then return end

    local item = Isaac.GetItemConfig():GetCollectible(type)
    if item.Type == ItemType.ITEM_ACTIVE or item.Type == ItemType.ITEM_TRINKET then return end
    table.insert(p.items, item.GfxFileName)
end
CoopHUDplus:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, addCollectibleToItems)
