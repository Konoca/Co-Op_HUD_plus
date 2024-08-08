local mod = CoopHUDplus

local DATA = mod.DATA

local Player = mod.Player
local Misc = mod.Misc

local game = Game()
local hud = game:GetHUD()

local abs = math.abs


-- Taken from reHUD, credit to Wofsauge
local function GetScreenSize()
    -- Credit to _Kilburn
    local room = game:GetRoom()
    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - game.ScreenShakeOffset

    local rx = pos.X + 60 * 26 / 40
    local ry = pos.Y + 140 * (26 / 40)

    return Vector(rx*2 + 13*26, ry*2 + 7*26)
end

local function GetScreenCenter()
    return GetScreenSize() / 2
end

local function leadingZero(val)
	if val<10 and val>=0 then
		return '0'..val
	end
	return val
end
--

local function renderTimerText(text)
    DATA.FONTS.timer:DrawStringScaled(
        text,
        GetScreenCenter().X - (Isaac.GetTextWidth(text)/2), 7,
        1, 1,
        KColor(1, 1, 1, 0.25),
        Isaac.GetTextWidth(text), true
    )
end

local function renderTimer(lastTimeString)
    if game:IsPaused() then
        renderTimerText(lastTimeString)
        return lastTimeString
    end

    local time = game.TimeCounter
    local secs = math.floor(time/30)%60
    local mins = math.floor(time/30/60)%60
    local hours = math.floor(time/30/60/60)%24
    local timestring = leadingZero(hours)..':'..leadingZero(mins)..':'..leadingZero(secs)

    renderTimerText(timestring)
    return timestring
end

local function setDefaultHUD(bool)
    if hud:IsVisible() and not bool then
        hud:SetVisible(bool)
    end
    if not hud:IsVisible() and bool then
        hud:SetVisible(bool)
    end
end

local function minimapConfig(setting, value)
    if not mod.config.mods.mAPI.override then
        MinimapAPI.OverrideConfig[setting] = MinimapAPI.Config[setting]
        return
    end

    if MinimapAPI.OverrideConfig[setting] ~= value then
        MinimapAPI.OverrideConfig[setting] = value
    end
end

local hudOff, lastTimeString = false, ''
local function RenderTimer()
    if mod.config.timer.display then
        lastTimeString = renderTimer(lastTimeString)
    end
end

local function RenderPlayers(screen_size, screen_center)
        local twins = 0
        local player_entity, pType = nil, nil
        local edge, edge_indexed, edge_multipliers = nil, nil, nil
        local color, pColor = Color(1, 1, 1, 1, 0, 0, 0), {1, 1, 1, 1}

        for i = 1, game:GetNumPlayers(), 1 do
            player_entity = Isaac.GetPlayer(i - 1)
            pType = player_entity:GetPlayerType()

            edge, edge_indexed = mod.config.offset + Vector.Zero, mod.config.offset + Vector.Zero
            edge_multipliers = Vector(1, 1)

            local number = i - twins

            if not Player.IsReal(pType) then
                twins = twins + 1
                number = (i - twins) * -1

                edge_indexed = edge_indexed + mod.config.twin_pos
            end

            if (abs(number) % 2) == 0 then
                edge_indexed.X = screen_size.X - (edge.X + mod.config.mirrored_extra_offset.X)
                edge_multipliers.X = -1
            end
            if abs(number) > 2 then
                edge_indexed.Y = screen_size.Y - (edge.Y + mod.config.mirrored_extra_offset.Y)
                edge_multipliers.Y = -1
            end

            pColor = Player.COLORS[abs(number)]
            color:SetColorize(pColor[1], pColor[2], pColor[3], pColor[4])
            if mod.config.player_colors then
                player_entity:SetColor(color, 15, 1, false, true)
            end

            if not DATA.PLAYERS[number] then
                DATA.PLAYERS[number] = {
                    ControllerIndex = player_entity.ControllerIndex,
                    PlayerType = pType,
                    Inventory = {},
                    Items = {},
                    Stats = {
                        Old = {},
                        Updates = {},
                    },
                    Pockets = {
                        Actives = {},
                    },
                }
            end

            Player.Render(edge, edge_indexed, edge_multipliers, pColor, player_entity, number, pType)
            if i == 1 then Misc.Render(screen_size, screen_center, player_entity) end
        end
end

local ItemSprite, _ = Sprite(mod.PATHS.ANIMATIONS.item, false)
local function RenderItems(screen_size)
    if not mod.config.items.display then return end

    local offset = Vector(0, 0)
    local anchors = screen_size * mod.config.items.anchors
    ItemSprite.Scale = mod.config.items.scale

    for i = #DATA.PLAYERS, 1, -1 do
        for _, v in pairs({-1, 1}) do
            local p = DATA.PLAYERS[i * v]
            if not p then goto skip_twin end
            local items = p.Items

            if mod.config.items.colors then
                local color = Color(1, 1, 1, 1, 0, 0, 0)
                local pColor = Player.COLORS[abs(i)]
                color:SetColorize(pColor[1], pColor[2], pColor[3], pColor[4])
                ItemSprite.Color = color
            end

            local pos = mod.config.items.pos + offset + anchors
            for j = #items - mod.config.items.items_per_player + 1, #items, 1 do
                if j < 1 then goto skip_item end
                ItemSprite:ReplaceSpritesheet(1, items[j])
                ItemSprite:LoadGraphics()
                ItemSprite:SetFrame('Idle', 0)

                ItemSprite:Render(pos)
                pos = pos + mod.config.items.offset
                ::skip_item::
            end
            offset = offset + mod.config.items.player_offset
            ::skip_twin::
        end
    end

end

local function RenderStreaks(screen_size, screen_center)
    if not DATA.STREAK then return end

    local pos = Vector(0, 0)
    if mod.config.streak.center_anchor then pos.X = screen_center.X end
    if mod.config.streak.bottom_anchor then pos.Y = screen_size.Y end
    pos = pos + mod.config.streak.pos

    DATA.STREAK.sprite:Update()
    DATA.STREAK.sprite:Render(pos, Vector.Zero, Vector.Zero)

    local frame = DATA.STREAK.sprite:GetFrame()
    if frame > 7 and frame < 60 then
        DATA.FONTS.streaks:DrawStringScaled(
            DATA.STREAK.name,
            pos.X + mod.config.streak.name.offset.X,
            pos.Y + mod.config.streak.name.offset.Y,
            mod.config.streak.name.scale.X,
            mod.config.streak.name.scale.Y,
            KColor.White,
            mod.config.streak.name.box_width,
            mod.config.streak.name.box_center
        )

        local conf = DATA.STREAK.invert_color and mod.config.streak.curse or mod.config.streak.description
        local color = DATA.STREAK.invert_color and KColor.Black or KColor.White
        DATA.FONTS.streaks:DrawStringScaled(
            DATA.STREAK.description,
            pos.X + conf.offset.X,
            pos.Y + conf.offset.Y,
            conf.scale.X,
            conf.scale.Y,
            color,
            conf.box_width,
            conf.box_center
        )
    end

    if DATA.STREAK.sprite:IsFinished() then
        DATA.STREAK = nil
    end
end

local function onRender()
    if mod.config.disable then return end
    if game:IsPaused() and not (game:IsPauseMenuOpen() and mod.config.display_during_pause) then return end

    -- TODO show character selection for players that are joining
    -- https://repentogon.com/HUD.html#getcoopmenusprite
    if #DATA.JOINING > 0 then
        -- For now, hide HUD if someone is joining.
        -- This is only a workaround until I can figure out how to determine what characters are unlocked
        setDefaultHUD(true)
        mod.IS_HUD_VISIBLE = false
        return
    end

    local screen_size, screen_center = GetScreenSize(), GetScreenCenter()

    if Input.IsButtonTriggered(Keyboard.KEY_H, 0) and not game:IsPaused() and mod.config.enable_toggle_hud then
        hudOff = not hudOff
    end
    setDefaultHUD(hudOff)
    mod.IS_HUD_VISIBLE = not hudOff
    if hudOff then return end

    if not DATA.FONTS.timer then return end

    RenderTimer()
    RenderPlayers(screen_size, screen_center)
    RenderItems(screen_size)
    RenderStreaks(screen_size, screen_center)

    -- mod overrides
    if MinimapAPI then
        -- https://github.com/TazTxUK/MinimapAPI/blob/master/scripts/minimapapi/config.lua
        minimapConfig('DisplayOnNoHUD', true)
        minimapConfig('DisplayMode', 2)
        minimapConfig('PositionX', mod.config.mods.mAPI.pos.X)
        minimapConfig('PositionY', mod.config.mods.mAPI.pos.Y)
        minimapConfig('MapFrameHeight', mod.config.mods.mAPI.frame.Y)
        minimapConfig('MapFrameWidth', mod.config.mods.mAPI.frame.Y)
        minimapConfig('DisplayLevelFlags', 2)
        minimapConfig('BorderColorA', 0.5)
    end

    mod.Utils.CreateCallback(mod.Callbacks.POST_HUD_RENDER, screen_size, screen_center)
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, onRender)