local mod = CoopHUDplus

-- Taken from reHUD, credit to Wofsauge
local function GetScreenSize()
    -- Credit to _Kilburn
    local room = Game():GetRoom()
    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - Game().ScreenShakeOffset

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
    local f, _ = Font(mod.PATHS.FONTS[mod.config.fonts.timer])
    f:DrawStringScaled(
        text,
        GetScreenCenter().X - (Isaac.GetTextWidth(text)/2), 7,
        1, 1,
        KColor(1, 1, 1, 0.25),
        Isaac.GetTextWidth(text), true
    )
    f:Unload()
end

local function renderTimer(game, lastTimeString)
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

local function setDefaultHUD(game, bool)
    local hud = game:GetHUD()
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


local game = Game()
local hudOff, lastTimeString = false, ''

local function RenderTimer()
    if mod.config.timer.display then
        lastTimeString = renderTimer(game, lastTimeString)
    end
end

local function RenderPlayers(screen_size, screen_center)
        local twins, is_twin = 0, false
        local player_entity, pType = nil, nil
        local edge, edge_indexed, edge_multipliers = nil, nil, nil
        local color, pColor = Color(1, 1, 1, 1, 0, 0, 0), nil
        for i = 1, game:GetNumPlayers(), 1 do
            player_entity = Isaac.GetPlayer(i - 1)
            pType = player_entity:GetPlayerType()

            edge, edge_indexed = mod.config.offset, mod.config.offset
            edge_multipliers = Vector(1, 1)

            is_twin = mod.Player.IsReal(pType)

            if is_twin then
                twins = twins + 1
                edge = edge + mod.config.twin_pos
                edge_indexed = edge_indexed + mod.config.twin_pos
            end

            local number = i - twins

            if (number % 2) == 0 then
                edge_indexed.X = screen_size.X - (edge.X + mod.config.mirrored_extra_offset.X)
                edge_multipliers.X = -1
            end
            if number > 2 then
                edge_indexed.Y = screen_size.Y - (edge.Y + mod.config.mirrored_extra_offset.Y)
                edge_multipliers.Y = -1
            end

            if mod.config.player_colors then
                pColor = mod.Player.COLORS[number]
                color:SetColorize(pColor[1], pColor[2], pColor[3], pColor[4])
                player_entity:SetColor(color, 15, 1, false, true)
            end

            mod.Player.Render(edge, edge_indexed, edge_multipliers, pColor, player_entity, number, pType, is_twin)
        end
end

local function RenderStreaks(screen_size, screen_center)
    if not mod.STREAK then return end
    local pos = Vector(0, 0)
    if mod.config.streak.center_anchor then pos.X = screen_center.X end
    if mod.config.streak.bottom_anchor then pos.Y = screen_size.Y end
    pos = pos + mod.config.streak.pos

    mod.STREAK.sprite:Update()
    mod.STREAK.sprite:Render(pos, Vector.Zero, Vector.Zero)

    local frame = mod.STREAK.sprite:GetFrame()
    if frame > 7 and frame < 60 then
        local f, _ = Font(mod.PATHS.FONTS[mod.config.fonts.streaks])
        f:DrawStringScaled(
            mod.STREAK.name,
            pos.X + mod.config.streak.name.offset.X,
            pos.Y + mod.config.streak.name.offset.Y,
            mod.config.streak.name.scale.X,
            mod.config.streak.name.scale.Y,
            KColor.White,
            mod.config.streak.name.box_width,
            mod.config.streak.name.box_center
        )

        local conf = mod.STREAK.invert_color and mod.config.streak.curse or mod.config.streak.description
        local color = mod.STREAK.invert_color and KColor.Black or KColor.White
        f:DrawStringScaled(
            mod.STREAK.description,
            pos.X + conf.offset.X,
            pos.Y + conf.offset.Y,
            conf.scale.X,
            conf.scale.Y,
            color,
            conf.box_width,
            conf.box_center
        )
        f:Unload()
    end

    if mod.STREAK.sprite:IsFinished() then
        mod.STREAK = nil
    end
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
    if mod.config.disable then return end
    if game:IsPaused() and not (game:IsPauseMenuOpen() and mod.config.display_during_pause) then return end

    -- TODO show character selection for players that are joining
    -- https://repentogon.com/HUD.html#getcoopmenusprite
    if #mod.DATA.JOINING > 0 then
        -- For now, hide HUD if someone is joining.
        -- This is only a workaround until I can figure out how to determine what characters are unlocked
        setDefaultHUD(game, true)
        mod.IS_HUD_VISIBLE = false
        return
    end

    local screen_size, screen_center = GetScreenSize(), GetScreenCenter()

    if Input.IsButtonTriggered(Keyboard.KEY_H, 0) and not game:IsPaused() and mod.config.enable_toggle_hud then
        hudOff = not hudOff
    end
    setDefaultHUD(game, hudOff)
    mod.IS_HUD_VISIBLE = not hudOff
    if hudOff then return end

    RenderTimer()
    RenderPlayers(screen_size, screen_center)
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

end)
