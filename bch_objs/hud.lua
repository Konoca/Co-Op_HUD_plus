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

local function renderPlayer(player_num, player_index, screen_size, screen_center)
    local p = Better_Coop_HUD.players[player_index]

    if not p or not p.is_real then return player_num end

    local idx = player_num + 1
    local isOnRight = (idx % 2) == 0
    local isOnBottom = (idx > 2)

    p:render(screen_size, screen_center, isOnRight, isOnBottom, Vector(0,0))
    return idx
end

local function minimapConfig(setting, value)
    if MinimapAPI.OverrideConfig[setting] ~= value then
        MinimapAPI.OverrideConfig[setting] = value
    end
end

local hudOff = false
local lastTimeString = ''
local function onRender()
    local game = Game()
    if Better_Coop_HUD.config.disable or game:IsPaused() then return end -- TODO HUD disappears when paused

    local screen_size = GetScreenSize()
    local screen_center = GetScreenCenter()

    -- toggle between HUD and default HUD
    if Input.IsButtonTriggered(Keyboard.KEY_H, 0) and not game:IsPaused() and Better_Coop_HUD.config.enable_toggle_hud then hudOff = not hudOff end
    setDefaultHUD(game, hudOff)
    if hudOff then return end

    -- timer
    lastTimeString = renderTimer(game, lastTimeString)

    -- players
    -- TODO everything messes up when coop players join, need to leave and continue to fix
    local player_num = 0
    for i = 0, #Better_Coop_HUD.players do
        if player_num >= game:GetNumPlayers() then break end
        player_num = renderPlayer(player_num, i, screen_size, screen_center)
    end

    -- bombs, keys, coins, etc.
    Better_Coop_HUD.Miscs.new():render(screen_center)

    -- TODO show character selection for players that are joining

    -- mod overrides
    if MinimapAPI then
        -- https://github.com/TazTxUK/MinimapAPI/blob/master/scripts/minimapapi/config.lua
        minimapConfig('DisplayOnNoHUD', true)
        minimapConfig('DisplayMode', 2)
        minimapConfig('PositionX', Better_Coop_HUD.config.mods.mAPI.pos.X)
        minimapConfig('PositionY', Better_Coop_HUD.config.mods.mAPI.pos.Y)
        minimapConfig('MapFrameHeight', Better_Coop_HUD.config.mods.mAPI.frame.Y)
        minimapConfig('MapFrameWidth', Better_Coop_HUD.config.mods.mAPI.frame.Y)
        minimapConfig('DisplayLevelFlags', 2)
        minimapConfig('BorderColorA', 0.5)
    end
    if EID and EID.UserConfig then
        -- https://github.com/wofsauge/External-Item-Descriptions/blob/master/eid_config.lua
        EID.UserConfig.YPosition = Better_Coop_HUD.config.mods.EID.YPosition
        EID.UserConfig.XPosition = Better_Coop_HUD.config.mods.EID.XPosition
        EID.UserConfig.DisplayMode = Better_Coop_HUD.config.mods.EID.DisplayMode
        EID.UserConfig.HUDOffset = Better_Coop_HUD.config.mods.EID.HUDOffset
    end
    if HPBars then
        -- https://github.com/wofsauge/Enhanced-Boss-Bars/blob/main/config.lua
    end
end

Better_Coop_HUD:AddCallback(ModCallbacks.MC_POST_RENDER, onRender)
