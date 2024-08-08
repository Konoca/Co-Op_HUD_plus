local mod = CoopHUDplus

function mod.Health.CHAPI.GetHeart(spriteFile, spriteAnim, spriteColor,
    goldenFile, goldenAnim, goldenColor, eternalFile, eternalAnim, eternalColor
)

    local sprite = {
        heart = Sprite(),
        golden = nil,
        eternal = nil,
    }

    sprite.heart:Load(spriteFile, true)
    sprite.heart:Play(spriteAnim, true)
    sprite.heart.Color = spriteColor

    if goldenFile ~= nil then
        sprite.golden = Sprite()
        sprite.golden:Load(goldenFile, true)
        sprite.golden:Play(goldenAnim, true)
        sprite.golden.Color = goldenColor
    end

    if eternalFile ~= nil then
        sprite.overlay = Sprite()
        sprite.overlay:Load(eternalFile, true)
        sprite.overlay:Play(eternalAnim, true)
        sprite.overlay.Color = eternalColor
    end

    return sprite
end

function mod.Health.CHAPI.GetHealth(player_entity, hasHoly)
    local hearts = {}

    -- Code taken directly from https://github.com/TaigaTreant/isaac-chapi/blob/main/customhealthapi/reimpl/renderhealthbar.lua#L387
    -- Modified to work with current rendering system
    local chapi = {}
    chapi.data = player_entity:GetData().CustomHealthAPISavedata
    if chapi.data == nil then return hearts end

    chapi.currentRedHealth = CustomHealthAPI.Helper.GetCurrentRedHealthForRendering(player_entity)
    chapi.currentOtherHealth = CustomHealthAPI.Helper.GetCurrentOtherHealthForRendering(player_entity)
    chapi.eternalIndex = CustomHealthAPI.Helper.GetEternalRenderIndex(player_entity)
    chapi.goldenMask = CustomHealthAPI.Helper.GetGoldenRenderMask(player_entity)

    chapi.redIdx = 1
    chapi.otherIdx = 1
    while chapi.currentOtherHealth[chapi.otherIdx] ~= nil do
        local animationFile = nil
        local animationName = nil

        local health = chapi.currentOtherHealth[chapi.otherIdx]
		local healthDefinition = CustomHealthAPI.PersistentData.HealthDefinitions[health.Key]

        local hasRedHealth = nil
        local redKey = nil
        local redHealth = nil
        local updateRedHealthIndex = nil

        animationFile, animationName, updateRedHealthIndex, hasRedHealth, redKey, redHealth = mod.Health.CHAPI.IfContainer(
            health, healthDefinition
        )

        local spriteFile, spriteAnim, spriteColor = nil, nil, nil
        local eternalFile, eternalAnim, eternalColor = nil, nil, nil
        local goldenFile, goldenAnim, goldenColor = nil, nil, nil

        if animationName ~= nil then
            spriteFile, spriteAnim, spriteColor = mod.Health.CHAPI.GetSprite(
                chapi, player_entity,
                animationName, animationFile,
                healthDefinition, hasRedHealth,
                redKey, redHealth,
                health, nil
            )
        end

        if chapi.otherIdx == chapi.eternalIndex and chapi.data.Overlays["ETERNAL_HEART"] > 0 then
            local eternalDefinition = CustomHealthAPI.PersistentData.HealthDefinitions["ETERNAL_HEART"]
			animationFile = eternalDefinition.AnimationFilename
			animationName = eternalDefinition.AnimationName
            eternalFile, eternalAnim, eternalColor = mod.Health.CHAPI.GetSprite(
                chapi, player_entity,
                animationName, animationFile,
                healthDefinition, hasRedHealth,
                redKey, nil,
                {Key = "ETERNAL_HEART", HP = 1}, nil
            )
        end

        if chapi.goldenMask[chapi.otherIdx] then
            local goldenDefinition = CustomHealthAPI.PersistentData.HealthDefinitions["GOLDEN_HEART"]
			animationFile = goldenDefinition.AnimationFilename
			animationName = goldenDefinition.AnimationName
            goldenFile, goldenAnim, goldenColor = mod.Health.CHAPI.GetSprite(
                chapi, player_entity,
                animationName, animationFile,
                healthDefinition, hasRedHealth,
                redKey, nil,
                {Key = "GOLDEN_HEART", HP = 1},
                Color(1.0, 1.0, 1.0, 1.0, 0/255, 0/255, 0/255)
            )
        end

        table.insert(hearts, mod.Health.CHAPI.GetHeart(
            spriteFile, spriteAnim, spriteColor,
            goldenFile, goldenAnim, goldenColor,
            eternalFile, eternalAnim, eternalColor
        ))

        if updateRedHealthIndex then chapi.redIdx = chapi.redIdx + 1 end
        chapi.otherIdx = chapi.otherIdx + 1
    end

    if hasHoly then
        hearts[#hearts]:setHolyMantle() -- TODO fix this
    end

    return hearts
end

function mod.Health.CHAPI.IfContainer(chapi, health, healthDefinition)
    local hasRedHealth = false
    local redKey = nil
    local redHealth = nil
    local updateRedHealthIndex = false

    local animationFile = nil
    local animationName = nil

    if healthDefinition.Type == CustomHealthAPI.Enums.HealthTypes.CONTAINER then
        animationFile = healthDefinition.AnimationFilename
        animationName = healthDefinition.AnimationName

        redHealth = chapi.currentRedHealth[chapi.redIdx]
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
                    print(mod.Name.." Custom Health API ERROR;" ..
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
            print(mod.Name.." Custom Health API ERROR:" ..
                "No animation name associated to health of other key " ..
                health.Key .. " and HP " .. tostring(health.HP) .. ".")
            return
        end

        animationName = healthDefinition.AnimationName[hp]
    end
    return animationFile, animationName, updateRedHealthIndex, hasRedHealth, redKey, redHealth
end

function mod.Health.CHAPI.GetSprite(chapi, player_entity,
        animationName, animationFile, healthDefinition,
        hasRedHealth, redKey, redHealth, health, color
    )

    local filename = animationFile
    local animname = animationName
    local isSubPlayer = player_entity:IsSubPlayer()
    if color == nil then
        color = CustomHealthAPI.Helper.GetHealthColor(
            healthDefinition,
            hasRedHealth,
            redKey,
            player_entity,
            chapi.otherIdx,
            chapi.redIdx,
            chapi.goldenMask[chapi.otherIdx],
            isSubPlayer
        )
    end

    local prevent = false
    local healthIndex = chapi.otherIdx - 1 + ((isSubPlayer and 6) or 0)
    local extraOffset = Vector(0,0)

    CustomHealthAPI.PersistentData.PreventResyncing = true
    local callbacks = CustomHealthAPI.Helper.GetCallbacks(CustomHealthAPI.Enums.Callbacks.PRE_RENDER_HEART)
    for _, callback in ipairs(callbacks) do
        local returnTable = callback.Function(
            player_entity,
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