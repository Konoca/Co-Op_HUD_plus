local mod = CoopHUDplus
local Health = mod.Health

local heartAnim = mod.PATHS.ANIMATIONS.hearts

local game = Game()
local hud = game:GetHUD()

require('scripts.compatabilities.CHAPI.main')


function Health.Heart.GetSpriteBasic(heartSprite, goldenSprite, overlaySprite)
    return {
        heart = heartSprite,
        golden = goldenSprite,
        overlay = overlaySprite,
    }
end

function Health.Heart.GetSprite(anim, isGolden, overlay)
    local sprite = {
        heart = nil,
        golden = nil,
        overlay = nil,
    }
    if anim then
        sprite.heart = Sprite()
        sprite.heart:Load(heartAnim, true)
        sprite.heart:SetFrame(anim, 0)
    end

    if isGolden then
        sprite.golden = Sprite()
        sprite.golden:Load(heartAnim, true)
        sprite.golden:SetFrame('GoldHeartOverlay', 0)
    end

    if overlay and overlay ~= '' then
        sprite.overlay = Sprite()
        sprite.overlay:Load(heartAnim, true)
        sprite.overlay:SetFrame(overlay, 0)
    end

    return sprite
end

function Health.Heart.GetHolyMantle(sprite)
    local anim = heartAnim

    if CustomHealthAPI ~= nil then
        anim = 'gfx/ui/CustomHealthAPI/hearts.anm2'
    end

    sprite.heart = Sprite()
    sprite.heart:Load(anim, true)
    sprite.heart:SetFrame('HolyMantle', 0)

    sprite.golden = nil
    sprite.overlay = nil

    return sprite
end

function Health.Heart.GetEternal(sprite)
    sprite.overlay = Sprite()
    sprite.overlay:Load(heartAnim, true)
    sprite.overlay:SetFrame('WhiteHeartOverlay', 0)

    return sprite
end

function Health.Heart.Render(sprite, pos, flip)
    if sprite.heart then
        sprite.heart.FlipX = flip
        sprite.heart:Render(pos)
    end

    if sprite.golden then
        sprite.golden.FlipX = flip
        sprite.golden:Render(pos)
    end

    if sprite.overlay then
        sprite.overlay.FlipX = flip
        sprite.overlay:Render(pos)
    end
end



function Health.GetHealth(player_entity, player_number, is_twin)
    local hearts = {}

    local level = game:GetLevel()
    local curses = level:GetCurses()

    if (curses & 8) == 8 and not mod.config.health.ignore_curse then
        return {Health.Heart.GetSprite('CurseHeart', false, nil)}
    end

    local pType = player_entity:GetPlayerType()

    -- Custom Heart API compatibility
    local hasHoly = player_entity:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    if CustomHealthAPI ~= nil
        and pType ~= PlayerType.PLAYER_THELOST and pType ~= PlayerType.PLAYER_THELOST_B
        and pType ~= PlayerType.PLAYER_KEEPER and pType ~= PlayerType.PLAYER_KEEPER_B
    then
        return Health.CHAPI.GetHealth(player_entity, hasHoly)
    end

    if CustomHealthAPI ~= nil then heartAnim = mod.PATHS.ANIMATIONS.hearts_copy end

    if pType == PlayerType.PLAYER_THESOUL_B
        or (pType == PlayerType.PLAYER_THELOST and not hasHoly)
        or (pType == PlayerType.PLAYER_THELOST_B and not hasHoly)
    then
        hearts = {}
    end

    local number = player_number
    if is_twin or number < 0 then number = math.abs(number) + 4 end
    local heartsHUD = hud:GetPlayerHUD(number - 1):GetHearts()

    local lastHeart, lastEternal = 1, -1
    local heartsSkipped = false
    for k, v in pairs(heartsHUD) do
        if not v:IsVisible() then
            table.insert(hearts, Health.Heart.GetSprite(nil, nil, nil))
            heartsSkipped = true
            goto skip_heart
        end

        local anim = v:GetHeartAnim()
        local golden = v:IsGoldenHeartOverlayVisible()
        local overlay = v:GetHeartOverlayAnim()

        table.insert(hearts, Health.Heart.GetSprite(anim, golden, nil))
        if not heartsSkipped then
            lastHeart = k
            if overlay ~= '' then lastEternal = k end
        end
        ::skip_heart::
    end

    if player_entity:GetEternalHearts() > 0 then
        Health.Heart.GetEternal(hearts[lastEternal])
    end

    if hasHoly then
        Health.Heart.GetHolyMantle(hearts[lastHeart])
    end

    for i = #hearts, 1, -1 do
        if hearts[i].heart ~= nil then break end
        hearts[i] = nil
    end

    return hearts
end

function Health.Render(edge_indexed, edge_multipliers, player_entity, player_number, is_twin)
    local pos = Vector(0, 0)
    local offset = Vector(0, 0)
    local edge = edge_indexed + (mod.config.health.pos * edge_multipliers)

    local hearts = Health.GetHealth(player_entity, player_number, is_twin)

    mod.Utils.CreateCallback(mod.Callbacks.PRE_HEALTH_RENDER, hearts, player_entity, player_number)

    local row = 0
    for i = 0, #hearts - 1, 1 do
        if i % mod.config.health.hearts_per_row == 0 and i ~= 0 then
            row = row + 1
            offset.X = 0
            offset.Y = offset.Y + mod.config.health.space_between_rows
        end

        pos = edge + (offset * edge_multipliers)

        Health.Heart.Render(hearts[i+1], pos, edge_multipliers.X == -1)

        offset.X = offset.X + mod.config.health.space_between_hearts
    end

    local extra_lives = player_entity:GetExtraLives()
    if extra_lives == 0 then return end

    pos = edge + (offset * edge_multipliers)
    local tmp = mod.config.health.space_between_hearts / 2
    pos.X = edge_multipliers.X == 1 and pos.X - tmp or pos.X + (tmp / 3)

    mod.DATA.FONTS.extra_lives:DrawStringScaled(
        'x'..extra_lives,
        pos.X, pos.Y,
        mod.config.stats.text.scale.X,
        mod.config.stats.text.scale.Y,
        KColor(1, 1, 1, 0.5),
        0, true
    )
end
