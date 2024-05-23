local mod = CoopHUDplus

local highestCallbackID = 0
for _, v in pairs(mod.Callbacks) do
    highestCallbackID = math.max(v, highestCallbackID)
    mod.DATA.CALLBACKS[v] = mod.DATA.CALLBACKS[v] or {}
end

function mod.Utils.CreateCallback(callbackID, ...)
    local callbacks = mod.DATA.CALLBACKS[callbackID]
    for _, callback in ipairs(callbacks) do
        callback.Function(...)
    end
end

function mod.Utils.AddCallback(modID, callbackID, func, ...)
    if callbackID < 1 or callbackID > highestCallbackID then
        print(mod.Name..' Error: Invalid Callback ID')
        return
    end

    local callbacks = mod.DATA.CALLBACKS[callbackID]
    callbacks[#callbacks+1] = {
        ModID = modID,
        CallbackID = callbackID,
        Function = func,
        Params = {...},
        Priority = 0,
    }
end

function mod.Utils.AddPriorityCallback(modID, callbackID, priority, func, ...)
    if callbackID < 1 or callbackID > highestCallbackID then
        print(mod.Name..' Error: Invalid Callback ID')
        return
    end

    local callbacks = mod.DATA.CALLBACKS[callbackID]
    local index = 1

    for i = #callbacks, 1, -1 do
        local callback = callbacks[i]
        if priority >= callback.Priority then
            index = i + 1
            break
        end
    end

    table.insert(callbacks, index, {
        ModID = modID,
        CallbackID = callbackID,
        Function = func,
        Params = {...},
        Priority = priority,
    })
end


function mod.Utils.encodeConfigVectors(config)
    local new_config = {}
    for key, value in pairs(config) do
        if key == nil or value == nil then goto skip_encode end
        if type(value) == 'table' then
            value = mod.Utils.encodeConfigVectors(value)
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

function mod.Utils.decodeConfigVectors(config)
    local new_config = {}
    for key, value in pairs(config) do
        local num = tonumber(key)
        if key == nil or value == nil then goto skip_decode end

        if type(key) == 'string' and num ~= nil then
            key = num
        end

        if type(value) == 'table' then
            value = mod.Utils.decodeConfigVectors(value)
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

function mod.Utils.ensureCompatibility(table1, table2)
    local new_config = {}
    for key, value in pairs(table1) do
        local new_value = table2[key]
        if new_value == nil then
            new_config[key] = value
            goto skip_key
        end

        if type(value) == 'table' then
            new_value = mod.Utils.ensureCompatibility(value, new_value)
        end

        new_config[key] = new_value
        ::skip_key::
    end
    return new_config
end

function mod.Utils.createStreak(name, description, display_bottom_paper)
    local animation = Sprite()
    animation:Load(mod.PATHS.ANIMATIONS.streak, true)
    if not display_bottom_paper then animation:ReplaceSpritesheet(1, '') end
    animation:LoadGraphics()
    animation:Play('Text', false)
    mod.STREAK = {sprite = animation, name = name, description = description, invert_color = display_bottom_paper}
end

local function isTwin(player)
    local pType = player:GetPlayerType()
    if pType == PlayerType.PLAYER_ESAU then return true end
    if pType == PlayerType.PLAYER_LAZARUS2_B then return true end
    return false
end
function mod.Utils.getPlayerFromEntity(player)
    local idx = player.ControllerIndex
    for i = 0, #mod.DATA.PLAYERS, 1 do
        if mod.DATA.PLAYERS[i] and mod.DATA.PLAYERS[i].player_entity.ControllerIndex == idx then
            if isTwin(player) then i = i + 1 end
            return mod.DATA.PLAYERS[i]
        end
    end
    return nil
end

