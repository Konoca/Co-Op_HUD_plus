local heartAnim = CoopHUDplus.PATHS.ANIMATIONS.hearts

function CoopHUDplus.Heart.new(heart_anim, is_golden, overlay)
    local self = setmetatable({}, CoopHUDplus.Heart)

    self.heart_anim = heart_anim
    self.is_golden = is_golden
    self.overlay_anim = overlay

    self.sprite = self:getSprite()

    return self
end

function CoopHUDplus.Heart.new_chapi(spriteFile, spriteAnim, spriteColor, goldenFile, goldenAnim, goldenColor, eternalFile, eternalAnim, eternalColor)
    local self = setmetatable({}, CoopHUDplus.Heart)

    self.sprite = {
        heart = Sprite(),
        golden = nil,
        eternal = nil,
    }

    self.sprite.heart:Load(spriteFile, true)
    self.sprite.heart:Play(spriteAnim, true)
    self.sprite.heart.Color = spriteColor

    if goldenFile ~= nil then
        self.sprite.golden = Sprite()
        self.sprite.golden:Load(goldenFile, true)
        self.sprite.golden:Play(goldenAnim, true)
        self.sprite.golden.Color = goldenColor
    end

    if eternalFile ~= nil then
        self.sprite.eternal = Sprite()
        self.sprite.eternal:Load(eternalFile, true)
        self.sprite.eternal:Play(eternalAnim, true)
        self.sprite.eternal.Color = eternalColor
    end

    return self
end

function CoopHUDplus.Heart.new_sprite(heart, golden_overlay, eternal_overlay)
    local self = setmetatable({}, CoopHUDplus.Heart)
    self.sprite = {
        heart = heart,
        golden = golden_overlay,
        eternal = eternal_overlay,
    }
    return self
end

function CoopHUDplus.Heart:updateSprite()
    self.sprite = self:getSprite()
end

function CoopHUDplus.Heart:getSprite()
    local sprite = {
        heart = nil,
        golden = nil,
        eternal = nil,
    }
    if self.heart_anim then
        sprite.heart = Sprite()
        sprite.heart:Load(heartAnim, true)
        sprite.heart:SetFrame(self.heart_anim, 0)
    end

    if self.is_golden then
        sprite.golden = Sprite()
        sprite.golden:Load(heartAnim, true)
        sprite.golden:SetFrame('GoldHeartOverlay', 0)
    end

    if self.overlay_anim and self.overlay_anim ~= '' then
        sprite.eternal = Sprite()
        sprite.eternal:Load(heartAnim, true)
        sprite.eternal:SetFrame(self.overlay_anim, 0)
    end

    return sprite
end

function CoopHUDplus.Heart:setHolyMantle()
    if CustomHealthAPI ~= nil then
        self.sprite.heart = Sprite()
        self.sprite.heart:Load('gfx/ui/CustomHealthAPI/hearts.anm2', true)
        self.sprite.heart:Play('HolyMantle', true)
        self.sprite.golden = nil
        self.sprite.eternal = nil
        return
    end

    self.heart_anim = 'HolyMantle'
    self:updateSprite()
end

function CoopHUDplus.Heart:render(pos, flip)
    if self.sprite.heart then
        self.sprite.heart.FlipX = flip
        self.sprite.heart:Render(pos)
    end

    if self.sprite.golden then
        self.sprite.golden.FlipX = flip
        self.sprite.golden:Render(pos)
    end

    if self.sprite.eternal then
        self.sprite.eternal.FlipX = flip
        self.sprite.eternal:Render(pos)
    end
end

function CoopHUDplus.Health.new(player_entity, player_number, is_twin)
    local self = setmetatable({}, CoopHUDplus.Health)
    self.player_entity = player_entity
    self.player_number = player_number
    self.pType = self.player_entity:GetPlayerType()
    self.is_twin = is_twin

    self.extra_lives = self.player_entity:GetExtraLives()

    self.eternal = self.player_entity:GetEternalHearts()
    self.hasHoly = self.player_entity:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)

    self.hearts = self:getHearts()

    if self.pType == PlayerType.PLAYER_THESOUL_B
        or (self.pType == PlayerType.PLAYER_THELOST and not self.hasHoly)
        or (self.pType == PlayerType.PLAYER_THELOST_B and not self.hasHoly)
    then
        self.hearts = {}
    end

    return self
end

function CoopHUDplus.Health:getHearts()
    local hearts = {}

    if (Game():GetLevel():GetCurses() & 8) == 8 and not CoopHUDplus.config.health.ignore_curse then
        local curse_heart = CoopHUDplus.Heart.new('CurseHeart', false, nil)
        table.insert(hearts, curse_heart)
        return hearts
    end

    -- Custom Heart API compatibility
    if CustomHealthAPI ~= nil
        and self.pType ~= PlayerType.PLAYER_THELOST and self.pType ~= PlayerType.PLAYER_THELOST_B
        and self.pType ~= PlayerType.PLAYER_KEEPER and self.pType ~= PlayerType.PLAYER_KEEPER_B
    then
        return self:getHeartsCHAPI()
    end

    if CustomHealthAPI ~= nil then heartAnim = CoopHUDplus.PATHS.ANIMATIONS.hearts_copy end

    local number = self.player_number
    if self.is_twin or number < 0 then number = math.abs(number) + 4 end
    if number >= 8 then number = 7 end
    local heartsHUD = Game():GetHUD():GetPlayerHUD(number):GetHearts()

    local lastHeart, lastEternal = 1, -1
    local heartsSkipped = false
    for k, v in pairs(heartsHUD) do
        if not v:IsVisible() then
            table.insert(hearts, CoopHUDplus.Heart.new(nil, nil, nil))
            heartsSkipped = true
            goto skip_heart
        end

        local anim = v:GetHeartAnim()
        local golden = v:IsGoldenHeartOverlayVisible()
        local overlay = v:GetHeartOverlayAnim()

        table.insert(hearts, CoopHUDplus.Heart.new(anim, golden, nil))
        if not heartsSkipped then
            lastHeart = k
            if overlay ~= '' then lastEternal = k end
        end
        ::skip_heart::
    end

    if self.eternal > 0 then
        hearts[lastEternal].overlay_anim = 'WhiteHeartOverlay'
        hearts[lastEternal]:updateSprite()
    end

    if self.hasHoly then
        hearts[lastHeart]:setHolyMantle()
    end

    return hearts
end

function CoopHUDplus.Health:getHeartsCHAPI()
    local hearts = {}

    -- Code taken directly from https://github.com/TaigaTreant/isaac-chapi/blob/main/customhealthapi/reimpl/renderhealthbar.lua#L387
    -- Modified to work with current rendering system
    self.chapi = {}
    self.chapi.data = self.player_entity:GetData().CustomHealthAPISavedata
    if self.chapi.data == nil then return hearts end

    self.chapi.currentRedHealth = CustomHealthAPI.Helper.GetCurrentRedHealthForRendering(self.player_entity)
    self.chapi.currentOtherHealth = CustomHealthAPI.Helper.GetCurrentOtherHealthForRendering(self.player_entity)
    self.chapi.eternalIndex = CustomHealthAPI.Helper.GetEternalRenderIndex(self.player_entity)
    self.chapi.goldenMask = CustomHealthAPI.Helper.GetGoldenRenderMask(self.player_entity)

    self.chapi.redIdx = 1
    self.chapi.otherIdx = 1
    while self.chapi.currentOtherHealth[self.chapi.otherIdx] ~= nil do
        local animationFile = nil
        local animationName = nil

        local health = self.chapi.currentOtherHealth[self.chapi.otherIdx]
		local healthDefinition = CustomHealthAPI.PersistentData.HealthDefinitions[health.Key]

        local hasRedHealth = nil
        local redKey = nil
        local redHealth = nil
        local updateRedHealthIndex = nil

        animationFile, animationName, updateRedHealthIndex, hasRedHealth, redKey, redHealth = self:_CHAPI_if_container(
            health, healthDefinition
        )

        local spriteFile, spriteAnim, spriteColor = nil, nil, nil
        local eternalFile, eternalAnim, eternalColor = nil, nil, nil
        local goldenFile, goldenAnim, goldenColor = nil, nil, nil

        if animationName ~= nil then
            spriteFile, spriteAnim, spriteColor = self:_CHAPI_get_sprite(
                animationName, animationFile,
                healthDefinition, hasRedHealth,
                redKey, redHealth,
                health, nil
            )
        end

        if self.chapi.otherIdx == self.chapi.eternalIndex and self.chapi.data.Overlays["ETERNAL_HEART"] > 0 then
            local eternalDefinition = CustomHealthAPI.PersistentData.HealthDefinitions["ETERNAL_HEART"]
			animationFile = eternalDefinition.AnimationFilename
			animationName = eternalDefinition.AnimationName
            eternalFile, eternalAnim, eternalColor = self:_CHAPI_get_sprite(
                animationName, animationFile,
                healthDefinition, hasRedHealth,
                redKey, nil,
                {Key = "ETERNAL_HEART", HP = 1}, nil
            )
        end

        if self.chapi.goldenMask[self.chapi.otherIdx] then
            local goldenDefinition = CustomHealthAPI.PersistentData.HealthDefinitions["GOLDEN_HEART"]
			animationFile = goldenDefinition.AnimationFilename
			animationName = goldenDefinition.AnimationName
            goldenFile, goldenAnim, goldenColor = self:_CHAPI_get_sprite(
                animationName, animationFile,
                healthDefinition, hasRedHealth,
                redKey, nil,
                {Key = "GOLDEN_HEART", HP = 1},
                Color(1.0, 1.0, 1.0, 1.0, 0/255, 0/255, 0/255)
            )
        end

        local heart = CoopHUDplus.Heart.new_chapi(spriteFile, spriteAnim, spriteColor, goldenFile, goldenAnim, goldenColor, eternalFile, eternalAnim, eternalColor)
        table.insert(hearts, heart)

        if updateRedHealthIndex then self.chapi.redIdx = self.chapi.redIdx + 1 end
        self.chapi.otherIdx = self.chapi.otherIdx + 1
    end

    if self.hasHoly then
        hearts[#hearts]:setHolyMantle()
    end

    return hearts
end

function CoopHUDplus.Health:_CHAPI_if_container(health, healthDefinition)
    local hasRedHealth = false
    local redKey = nil
    local redHealth = nil
    local updateRedHealthIndex = false

    local animationFile = nil
    local animationName = nil

    if healthDefinition.Type == CustomHealthAPI.Enums.HealthTypes.CONTAINER then
        animationFile = healthDefinition.AnimationFilename
        animationName = healthDefinition.AnimationName

        redHealth = self.chapi.currentRedHealth[self.chapi.redIdx]
        if redHealth ~= nil then
            local redHealthDefinition = CustomHealthAPI.PersistentData.HealthDefinitions[redHealth.Key]
            local redToOtherNames = redHealthDefinition.AnimationNames

            if redToOtherNames[health.Key] ~= nil then
                local names = redToOtherNames[health.Key]

                local hp = redHealth.HP
                while names[hp] == nil and hp > 0 do
                    hp = hp - 1
                end

                if names[hp] == nil then
                    print("CoopHUDplus Custom Health API ERROR;" ..
                        " No animation name associated to health of red key " ..
                        redHealth.Key ..
                        ", other key " ..
                        health.Key ..
                        " and HP " ..
                        tostring(redHealth.HP) .. ".")
                    return
                end

                animationFile = redHealthDefinition.AnimationFilenames[health.Key]
                animationName = names[hp]

                hasRedHealth = true
                redKey = redHealth.Key
            end

            updateRedHealthIndex = true
        end
    else
        animationFile = healthDefinition.AnimationFilename

        local hp = health.HP
        while healthDefinition.AnimationName[hp] == nil and hp > 0 do
            hp = hp - 1
        end

        if healthDefinition.AnimationName[hp] == nil then
            print("CoopHUDplus Custom Health API ERROR:" ..
                "No animation name associated to health of other key " ..
                health.Key .. " and HP " .. tostring(health.HP) .. ".")
            return
        end

        animationName = healthDefinition.AnimationName[hp]
    end
    return animationFile, animationName, updateRedHealthIndex, hasRedHealth, redKey, redHealth
end

function CoopHUDplus.Health:_CHAPI_get_sprite(animationName, animationFile, healthDefinition, hasRedHealth, redKey, redHealth, health, color)
    local filename = animationFile
    local animname = animationName
    local isSubPlayer = self.player_entity:IsSubPlayer()
    if color == nil then
        color = CustomHealthAPI.Helper.GetHealthColor(
            healthDefinition,
            hasRedHealth,
            redKey,
            self.player_entity,
            self.chapi.otherIdx,
            self.chapi.redIdx,
            self.chapi.goldenMask[self.chapi.otherIdx],
            isSubPlayer
        )
    end

    local prevent = false
    local healthIndex = self.chapi.otherIdx - 1 + ((isSubPlayer and 6) or 0)
    local extraOffset = Vector(0,0)

    CustomHealthAPI.PersistentData.PreventResyncing = true
    local callbacks = CustomHealthAPI.Helper.GetCallbacks(CustomHealthAPI.Enums.Callbacks.PRE_RENDER_HEART)
    for _, callback in ipairs(callbacks) do
        local returnTable = callback.Function(
            self.player_entity,
            healthIndex,
            health,
            redHealth,
            filename,
            animname,
            Color.Lerp(color, Color(1,1,1,1,0,0,0), 0),
            extraOffset
        )
        if returnTable ~= nil then
            if returnTable.Prevent == true then
                prevent = true
            end
            if returnTable.Index ~= nil then
                healthIndex = returnTable.Index
            end
            if returnTable.AnimationFilename ~= nil then
                filename = returnTable.AnimationFilename
            end
            if returnTable.AnimationName ~= nil then
                animname = returnTable.AnimationName
            end
            if returnTable.Color ~= nil then
                color = returnTable.Color
            end
            if returnTable.Offset ~= nil then
                extraOffset = returnTable.Offset
            end
            break
        end
    end
    CustomHealthAPI.PersistentData.PreventResyncing = false
    if prevent then return nil end

    return filename, animname, color
end

function CoopHUDplus.Health:render(edge_indexed, edge_multipliers)
    local pos = Vector(0, 0)
    local offset = Vector(0, 0)
    local edge = edge_indexed + (CoopHUDplus.config.health.pos * edge_multipliers)

    CoopHUDplus.Utils.CreateCallback(CoopHUDplus.Callbacks.PRE_HEALTH_RENDER, self, self.player_entity)

    local row = 0
    for i = 0, #self.hearts - 1, 1 do
        if i % CoopHUDplus.config.health.hearts_per_row == 0 and i ~= 0 then
            row = row + 1
            offset.X = 0
            offset.Y = offset.Y + CoopHUDplus.config.health.space_between_rows
        end

        pos = edge + (offset * edge_multipliers)
--
        self.hearts[i+1]:render(pos, edge_multipliers.X == -1)

        offset.X = offset.X + CoopHUDplus.config.health.space_between_hearts
    end


    if self.extra_lives == 0 then return end

    pos = edge + (offset * edge_multipliers)
    local tmp = CoopHUDplus.config.health.space_between_hearts / 2
    pos.X = edge_multipliers.X == 1 and pos.X - tmp or pos.X + (tmp / 3)

    local f, _ = Font(CoopHUDplus.PATHS.FONTS[CoopHUDplus.config.fonts.extra_lives])
    f:DrawStringScaled(
        'x'..self.extra_lives,
        pos.X, pos.Y,
        CoopHUDplus.config.stats.text.scale.X,
        CoopHUDplus.config.stats.text.scale.Y,
        KColor(1, 1, 1, 0.5),
        0, true
    )
    f:Unload()
end
