CoopHUDplus.Utils = {}

local highestCallbackID = 0
for _, v in pairs(CoopHUDplus.Callbacks) do
    highestCallbackID = math.max(v, highestCallbackID)
    CoopHUDplus.DATA.CALLBACKS[v] = CoopHUDplus.DATA.CALLBACKS[v] or {}
end

function CoopHUDplus.Utils.CreateCallback(callbackID, ...)
    local callbacks = CoopHUDplus.DATA.CALLBACKS[callbackID]
    for _, callback in ipairs(callbacks) do
        callback.Function(...)
    end
end

function CoopHUDplus.Utils.AddCallback(modID, callbackID, func, ...)
    if callbackID < 1 or callbackID > highestCallbackID then
        print('Co-Op HUD+ Error: Invalid Callback ID')
        return
    end

    local callbacks = CoopHUDplus.DATA.CALLBACKS[callbackID]
    callbacks[#callbacks+1] = {
        ModID = modID,
        CallbackID = callbackID,
        Function = func,
        Params = {...},
        Priority = 0,
    }
end

function CoopHUDplus.Utils.AddPriorityCallback(modID, callbackID, priority, func, ...)
    if callbackID < 1 or callbackID > highestCallbackID then
        print('Co-Op HUD+ Error: Invalid Callback ID')
        return
    end

    local callbacks = CoopHUDplus.DATA.CALLBACKS[callbackID]
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


function CoopHUDplus.Utils.encodeConfigVectors(config)
    local new_config = {}
    for key, value in pairs(config) do
        if key == nil or value == nil then goto skip_encode end
        if type(value) == 'table' then
            value = CoopHUDplus.Utils.encodeConfigVectors(value)
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

function CoopHUDplus.Utils.decodeConfigVectors(config)
    local new_config = {}
    for key, value in pairs(config) do
        local num = tonumber(key)
        if key == nil or value == nil then goto skip_decode end

        if type(key) == 'string' and num ~= nil then
            key = num
        end

        if type(value) == 'table' then
            value = CoopHUDplus.Utils.decodeConfigVectors(value)
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

function CoopHUDplus.Utils.ensureCompatibility(table1, table2)
    local new_config = {}
    for key, value in pairs(table1) do
        local new_value = table2[key]
        if new_value == nil then
            new_config[key] = value
            goto skip_key
        end

        if type(value) == 'table' then
            new_value = CoopHUDplus.Utils.ensureCompatibility(value, new_value)
        end

        new_config[key] = new_value
        ::skip_key::
    end
    return new_config
end

function CoopHUDplus.Utils.createStreak(name, description, display_bottom_paper)
    local animation = Sprite()
    animation:Load(CoopHUDplus.PATHS.ANIMATIONS.streak, true)
    if not display_bottom_paper then animation:ReplaceSpritesheet(1, '') end
    animation:LoadGraphics()
    animation:Play('Text', false)
    CoopHUDplus.STREAK = {sprite = animation, name = name, description = description, invert_color = display_bottom_paper}
end

function CoopHUDplus.Utils.getPlayerFromEntity(player)
    local idx = player.ControllerIndex
    for i = 0, #CoopHUDplus.players, 1 do
        if CoopHUDplus.players[i] and CoopHUDplus.players[i].player_entity.ControllerIndex == idx then
            return CoopHUDplus.players[i]
        end
    end
    return nil
end

