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
    Isaac.RenderScaledText(text, GetScreenCenter().X - (Isaac.GetTextWidth(text)/2), 7, 1, 1, 1, 1, 1, 0.25)
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
    if not CoopHUDplus.config.mods.mAPI.override then
        MinimapAPI.OverrideConfig[setting] = MinimapAPI.Config[setting]
        return
    end

    if MinimapAPI.OverrideConfig[setting] ~= value then
        MinimapAPI.OverrideConfig[setting] = value
    end
end

local hudOff = false
local lastTimeString = ''
local function onRender()
    local game = Game()
    if CoopHUDplus.config.disable then return end
    if game:IsPaused() and not (game:IsPauseMenuOpen() and CoopHUDplus.config.display_during_pause) then return end

    -- TODO show character selection for players that are joining
    -- For now, hide HUD if someone is joining.
    -- This is only a workaround until I can figure out how to determine what characters are unlocked
    -- https://repentogon.com/HUD.html#getcoopmenusprite
    if #CoopHUDplus.joining > 0 then
        setDefaultHUD(game, true)
        CoopHUDplus.IS_HUD_VISIBLE = false
        return
    end

    local screen_size = GetScreenSize()
    local screen_center = GetScreenCenter()

    -- toggle between HUD and default HUD
    if Input.IsButtonTriggered(Keyboard.KEY_H, 0) and not game:IsPaused() and CoopHUDplus.config.enable_toggle_hud then
        hudOff = not hudOff
    end
    setDefaultHUD(game, hudOff)
    CoopHUDplus.IS_HUD_VISIBLE = not hudOff
    if hudOff then return end

    -- timer
    lastTimeString = renderTimer(game, lastTimeString)

    -- players
    local twins = 0
    for i = 0, game:GetNumPlayers() - 1, 1 do
        local player = Isaac.GetPlayer(i)
        if CoopHUDplus.players[i] then CoopHUDplus.players[i]:update(player) end
        if not CoopHUDplus.players[i] then
            CoopHUDplus.players[i] = CoopHUDplus.Player.new(player, i - twins)
        end

        local p = CoopHUDplus.players[i]
        if not p.is_real then twins = twins + 1 end
        if p.is_real then
            local idx = p.number + 1
            local isOnRight = (idx % 2) == 0
            local isOnBottom = (idx > 2)

            local color = Color(1, 1, 1, 1, 0, 0, 0)
            local pColor = CoopHUDplus.Player.COLORS[idx]
            color:SetColorize(pColor[1], pColor[2], pColor[3], pColor[4])
            if CoopHUDplus.config.player_colors then p.player_entity:SetColor(color, 15, 1, false, true) end

            p:render(screen_size, screen_center, isOnRight, isOnBottom, Vector(0,0), pColor)
        end
    end

    -- player items
    local offset = Vector(0, 0)
    local anchors = screen_size * CoopHUDplus.config.items.anchors
    local sprite, _ = Sprite(CoopHUDplus.PATHS.ANIMATIONS.item, false)
    sprite.Scale = CoopHUDplus.config.items.scale
    if CoopHUDplus.config.items.display then
        for i = #CoopHUDplus.players, 0, -1 do
            local p = CoopHUDplus.players[i]
            local items = p.items

            local num = p.number
            if not p.is_real then
                num = math.abs(p.number) - 1
            end

            if CoopHUDplus.config.items.colors then
                local color = Color(1, 1, 1, 1, 0, 0, 0)
                local pColor = CoopHUDplus.Player.COLORS[num + 1]
                color:SetColorize(pColor[1], pColor[2], pColor[3], pColor[4])
                sprite.Color = color
            end

            local pos = CoopHUDplus.config.items.pos + offset + anchors
            for j = #items - CoopHUDplus.config.items.items_per_player + 1, #items, 1 do
                if j < 1 then goto skip_item end
                sprite:ReplaceSpritesheet(1, items[j])
                sprite:LoadGraphics()
                sprite:SetFrame('Idle', 0)

                sprite:Render(pos)
                pos = pos + CoopHUDplus.config.items.offset
                ::skip_item::
            end
            offset = offset + CoopHUDplus.config.items.player_offset
        end
    end

    -- bombs, keys, coins, etc.
    CoopHUDplus.Miscs.new():render(screen_size, screen_center)

    -- UI streak animation
    if CoopHUDplus.STREAK then
        local pos = Vector(0, 0)
        if CoopHUDplus.config.streak.center_anchor then pos.X = screen_center.X end
        if CoopHUDplus.config.streak.bottom_anchor then pos.Y = screen_size.Y end
        pos = pos + CoopHUDplus.config.streak.pos

        CoopHUDplus.STREAK.sprite:Update()
        CoopHUDplus.STREAK.sprite:Render(pos, Vector.Zero, Vector.Zero)

        local frame = CoopHUDplus.STREAK.sprite:GetFrame()
        if frame > 7 and frame < 60 then
            local f, _ = Font(CoopHUDplus.PATHS.FONTS.streak)
            f:DrawStringScaled(
                CoopHUDplus.STREAK.name,
                pos.X + CoopHUDplus.config.streak.name.offset.X,
                pos.Y + CoopHUDplus.config.streak.name.offset.Y,
                CoopHUDplus.config.streak.name.scale.X,
                CoopHUDplus.config.streak.name.scale.Y,
                KColor.White,
                CoopHUDplus.config.streak.name.box_width,
                CoopHUDplus.config.streak.name.box_center
            )

            local conf = CoopHUDplus.STREAK.invert_color and CoopHUDplus.config.streak.curse or CoopHUDplus.config.streak.description
            f:DrawStringScaled(
                CoopHUDplus.STREAK.description,
                pos.X + conf.offset.X,
                pos.Y + conf.offset.Y,
                conf.scale.X,
                conf.scale.Y,
                CoopHUDplus.STREAK.invert_color and KColor.Black or KColor.White,
                conf.box_width,
                conf.box_center
            )
        end

        if CoopHUDplus.STREAK.sprite:IsFinished() then
            CoopHUDplus.STREAK = nil
        end
    end

    -- mod overrides
    if MinimapAPI then
        -- https://github.com/TazTxUK/MinimapAPI/blob/master/scripts/minimapapi/config.lua
        minimapConfig('DisplayOnNoHUD', true)
        minimapConfig('DisplayMode', 2)
        minimapConfig('PositionX', CoopHUDplus.config.mods.mAPI.pos.X)
        minimapConfig('PositionY', CoopHUDplus.config.mods.mAPI.pos.Y)
        minimapConfig('MapFrameHeight', CoopHUDplus.config.mods.mAPI.frame.Y)
        minimapConfig('MapFrameWidth', CoopHUDplus.config.mods.mAPI.frame.Y)
        minimapConfig('DisplayLevelFlags', 2)
        minimapConfig('BorderColorA', 0.5)
    end
    -- if EID and EID.UserConfig and CoopHUDplus.config.mods.EID.override then
    --     -- https://github.com/wofsauge/External-Item-Descriptions/blob/master/eid_config.lua
    --     EID.UserConfig.YPosition = CoopHUDplus.config.mods.EID.YPosition
    --     EID.UserConfig.XPosition = CoopHUDplus.config.mods.EID.XPosition
    --     EID.UserConfig.DisplayMode = CoopHUDplus.config.mods.EID.DisplayMode
    --     EID.UserConfig.HUDOffset = CoopHUDplus.config.mods.EID.HUDOffset
    -- end
    -- if HPBars then
    --    -- https://github.com/wofsauge/Enhanced-Boss-Bars/blob/main/config.lua
    -- end
end

CoopHUDplus:AddCallback(ModCallbacks.MC_POST_RENDER, onRender)
