local mod = CoopHUDplus

local game = Game()

local BlessingSprite, _ = Sprite(mod.PATHS.ANIMATIONS.stats, false)
BlessingSprite:ReplaceSpritesheet(0, 'gfx/ui/hudstats3.png')
BlessingSprite:SetFrame('Idle', 0)
BlessingSprite:LoadGraphics()

local function JerichoBlessingStat(stats, _, player_number)
    if player_number ~= 1 then return end
    if not PlayerManager.AnyoneIsPlayerType(_JERICHO_MOD.Character.JERICHO) then return end

    if Game():GetLevel():GetCurses() == LevelCurse.CURSE_NONE then return end

    local stat = mod.Stats.Stat.GetStat(_JERICHO_MOD.GetBlessingChance() * 100, 0, true)
    stat.Sprite = BlessingSprite

    table.insert(stats, stat)
end


local iconSprite = Sprite("gfx/ui/mapitemicons2.anm2", true)
local function JerichoCurseIcon(screen_size, _)
    if not PlayerManager.AnyoneIsPlayerType(_JERICHO_MOD.Character.JERICHO) then return end

    local level = game:GetLevel()
    local curse = level:GetCurses()
    if curse == LevelCurse.CURSE_NONE then return end

    iconSprite:Render(Vector(screen_size.X-15, 74))

    for curseIndex, curseName in pairs(_JERICHO_MOD.CurseBlessing) do
        if curse & curseName > 0 then
            iconSprite:SetFrame("curses", curseIndex - 1)
            break
        end
    end
end


local function AddCallbacks()
    local modID = _JERICHO_MOD.Name
    mod.Utils.AddCallback(modID, mod.Callbacks.PRE_STATS_RENDER, JerichoBlessingStat)
    mod.Utils.AddCallback(modID, mod.Callbacks.POST_HUD_RENDER, JerichoCurseIcon)
end
return AddCallbacks
