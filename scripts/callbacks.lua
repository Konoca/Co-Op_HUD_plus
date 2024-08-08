local json = require('json')

local mod = CoopHUDplus
local DATA = mod.DATA
local Utils = mod.Utils
local Inventory = mod.Inventory

local game = Game()

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


local function onGameStart(_, isCont)
    DATA.PLAYERS = {}
    DATA.JOINING = {}
    DATA.PILLS = {
        cache = {},
        known = {},
    }

    if not mod:HasData() then return end
    local data = json.decode(mod:LoadData())

    if data.config then
        local savedData = Utils.decodeConfigVectors(data.config)
        if savedData.version ~= nil then
            mod.config = Utils.ensureCompatibility(mod.config, savedData)
            mod.config.version = mod.version
        end
    end

    Utils.LoadFonts()

    if isCont then
        DATA.PLAYERS = data.players
        DATA.PILLS = data.pills
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onGameStart)

local function saveGame(saveGameData)
    local data = {}
    data.config = Utils.encodeConfigVectors(mod.config)

    if saveGameData then
        data.pills = DATA.PILLS
        data.players = DATA.PLAYERS

        if data.pills.cache then
            local lastCache, largestPill = 0, 0
            for k, v in pairs(data.pills.cache) do lastCache, largestPill = k, v end

            for i = 1, lastCache, 1 do if not data.pills.cache[i] then data.pills.cache[i] = false end end
            for i = 1, largestPill, 1 do if not data.pills.known[i] then data.pills.known[i] = false end end
        end
    end

    local jsonString = json.encode(data)
    mod:SaveData(jsonString)
end

local function onGameExit(_, shouldSave)
    saveGame(shouldSave)
    Utils.UnloadFonts()
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, onGameExit)

local function getPill(_, pillEffect, pillColor)
    DATA.PILLS.cache[pillColor] = pillEffect
end
mod:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, getPill)


local function getPlayerExists(idx)
    for i = 1, #DATA.PLAYERS, 1 do
        if DATA.PLAYERS[i].ControllerIndex == idx then
            return true
        end
    end
    return false
end
local function getJoining(idx)
    for i = 1, #DATA.JOINING, 1 do
        if DATA.JOINING[i].controller_index == idx then
            DATA.JOINING[i].idx = i
            return DATA.JOINING[i]
        end
    end
    return nil
end


local function initNewPlayer(_)
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

            table.insert(DATA.JOINING, {
                idx = nil,
                controller_index = i,
                currently_selected = 0,
                number = #DATA.PLAYERS + #DATA.JOINING + 1
            })
            ::skip_init::
        end
    end
end
local function selectCharacter(_)
    if game:IsPaused() then return end

    for i = 0, 4 +1, 1 do
        local joining = getJoining(i)
        if not joining then goto skip_select end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENULEFT, i) then
        end
        if Input.IsActionTriggered(ButtonAction.ACTION_MENURIGHT, i) then
        end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENUBACK, i) then
            table.remove(DATA.JOINING, joining.idx)
        end

        if Input.IsActionTriggered(ButtonAction.ACTION_MENUCONFIRM, i) then
            table.remove(DATA.JOINING, joining.idx)
        end

        ::skip_select::
    end
end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, initNewPlayer)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, selectCharacter)

local function newLevel(_)
    local level = game:GetLevel()
    local name = level:GetName()
    local curse = level:GetCurseName()
    Utils.createStreak(name, curse, curse ~= '')


    if level:GetStage() ~= LevelStage.STAGE1_1 then
        saveGame(true)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, newLevel)


-- requires Repentogon
local function addCollectible(_ ,type, _, _, _, _, player)
    local item = Isaac.GetItemConfig():GetCollectible(type)
    local level = game:GetLevel()

    if level:GetAbsoluteStage() == LevelStage.STAGE1_1
        and level:GetCurrentRoomIndex() == level:GetStartingRoomIndex()
        and game:GetRoom():IsFirstVisit() then
        return
    end

    local xmldata = XMLData.GetEntryById(XMLNode.ITEM, type)
    local name = xmldata.name
    local description = xmldata.description
    Utils.createStreak(name, description, false)

    if item.Type == ItemType.ITEM_ACTIVE or item.Type == ItemType.ITEM_TRINKET then return end
    if ignored_ids[item.ID] then return end

    local p = Utils.getPlayerFromEntity(player)
    if not p then return end

    Inventory.Add(player, p, item)
end
local function shiftCollectibles(_, entityPlayer, _)
    if game:IsPaused() then return end

    if Input.IsActionTriggered(ButtonAction.ACTION_DROP, entityPlayer.ControllerIndex) then
        local p = Utils.getPlayerFromEntity(entityPlayer)
        if p then Inventory.Shift(p) end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, addCollectible)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, shiftCollectibles, 0)


local function usePill(_, pillEffect, entityPlayer, useFlags)
    DATA.PILLS.known[pillEffect] = true

    local xmldata = XMLData.GetEntryById(XMLNode.PILL, pillEffect)
    local name = xmldata.name
    local description = xmldata.description
    Utils.createStreak(name, description, false)
end
mod:AddCallback(ModCallbacks.MC_USE_PILL, usePill)

local function useCard(_, card, entityPlayer, useFlags)
    local xmldata = XMLData.GetEntryById(XMLNode.CARD, card)
    local name = xmldata.name
    local description = xmldata.description
    Utils.createStreak(name, description, false)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, useCard)

local function pickupTrinket(_, entityPlayer, trinketType, firstTime)
    local xmldata = XMLData.GetEntryById(XMLNode.TRINKET, trinketType)
    local name = xmldata.name
    local description = xmldata.description
    Utils.createStreak(name, description, false)
end
mod:AddCallback(ModCallbacks.MC_POST_TRIGGER_TRINKET_ADDED, pickupTrinket)

local function addCollectibleToItems(_ ,type, _, _, _, _, player)
    local p = Utils.getPlayerFromEntity(player)
    if not p then return end

    local item = Isaac.GetItemConfig():GetCollectible(type)
    if item.Type == ItemType.ITEM_ACTIVE or item.Type == ItemType.ITEM_TRINKET then return end
    table.insert(p.Items, item.GfxFileName)
end
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, addCollectibleToItems)
