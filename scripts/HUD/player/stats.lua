local mod = CoopHUDplus
local Stats = mod.Stats

local DATA = mod.DATA

local game = Game()

local IconSprite = Sprite()
IconSprite:Load(CoopHUDplus.PATHS.ANIMATIONS.stats, true)


function Stats.Stat.GetStat(value, stat, is_percent)
    return {
        Frame = stat,
        String = string.format(is_percent and '%.1f%%' or '%.2f', value),
        IsPercent = is_percent,
        Value = value,
    }
end

function Stats.Stat.Render(stat, pos_vector, text_pos_vector, render_icon, pColor)
    if stat.String == nil then return end

    local sprite = IconSprite
    if stat.Sprite ~= nil then
        sprite = stat.Sprite
    end

    if render_icon then
        sprite.Scale = mod.config.stats.scale
        sprite:SetFrame('Idle', stat.Frame)
        sprite:Render(pos_vector)
    end

    DATA.FONTS.stats:DrawStringScaled(
        stat.String,
        text_pos_vector.X, text_pos_vector.Y,
        mod.config.stats.text.scale.X,
        mod.config.stats.text.scale.Y,
        KColor(pColor[1], pColor[2], pColor[3], 0.5),
        0, true
    )
end


function Stats.GetDevilAngelChance()
    local level = game:GetLevel()
    local room = game:GetRoom()
    local stage = level:GetStage()

    local curses = level:GetCurses()

    -- stages where you cant get a deal
    local disallowed_stages = {
        [LevelStage.STAGE4_3] = true,
        [LevelStage.STAGE5] = true,
        [LevelStage.STAGE6] = true,
        [LevelStage.STAGE7] = true,
        [LevelStage.STAGE8] = true,
    }

    local chances = {
        deal = 0.0,
        calc = 0.0,
        angel = 0.0,
        devil = 0.0,
        duality = false,
    }

    if level:IsPreAscent() then return chances end
    if disallowed_stages[stage] then return chances end

    if stage == LevelStage.STAGE1_1
        and (curses & LevelCurse.CURSE_OF_LABYRINTH) ~= LevelCurse.CURSE_OF_LABYRINTH
        and not level:IsAltStage()
    then return chances end

    chances.deal = room:GetDevilRoomChance()
    chances.deal = chances.deal > 1 and 1 or chances.deal

    chances.angel = 1.0

    local mods = {}

    local collectibles = {
        [CollectibleType.COLLECTIBLE_KEY_PIECE_1] = 0.75,
        [CollectibleType.COLLECTIBLE_KEY_PIECE_2] = 0.75,
        [CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES] = 0.75,
    }

    local trinkets = {
        [TrinketType.TRINKET_ROSARY_BEAD] = 0.5,
    }

    local level_flags = {
        [LevelStateFlag.STATE_BUM_KILLED] = 0.75,
        [LevelStateFlag.STATE_BUM_LEFT] = 0.9,
        [LevelStateFlag.STATE_EVIL_BUM_LEFT] = 1.1,
    }

    local eucharist = false
    local book_of_virtues = false
    for i = 0, game:GetNumPlayers() - 1, 1 do
        local p = Isaac.GetPlayer(i)

        for k, v in pairs(collectibles) do
            if p:HasCollectible(k) then
                table.insert(mods, v)
            end
        end
        for k, v in pairs(trinkets) do
            if p:HasTrinket(k) then
                table.insert(mods, v)
            end
        end

        if p:HasCollectible(CollectibleType.COLLECTIBLE_EUCHARIST) then eucharist = true end
        if p:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) then book_of_virtues = true end
        if p:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then chances.duality = true end
    end
    if eucharist then
        -- https://bindingofisaacrebirth.fandom.com/wiki/Eucharist
        chances.devil = 0
        chances.angel = 1
        return chances
    end

    -- check level flags
    for k, v in pairs(level_flags) do
        if level:GetStateFlag(k) then
            table.insert(mods, v)
        end
    end

    -- donation machine
    if game:GetDonationModAngel() >= 10 then
        table.insert(mods, 0.5)
    end

    -- calculation
    local devil_spawned = game:GetStateFlag(GameStateFlag.STATE_DEVILROOM_SPAWNED)
    local devil_visited = game:GetStateFlag(GameStateFlag.STATE_DEVILROOM_VISITED)
    local devil_item_taken = game:GetDevilRoomDeals() > 0
    local angel_spawned = game:GetStateFlag(GameStateFlag.STATE_FAMINE_SPAWNED) -- repurposed state in Rep
    if devil_visited and not devil_item_taken then
        chances.calc = 0.5
        for i = 1, #mods, 1 do
            chances.calc = chances.calc * mods[i]
        end

        chances.calc = 1.0 - (chances.calc * (1.0 - level:GetAngelRoomChance()))
    end

    chances.devil = chances.deal * (1.0 - chances.calc)
    chances.angel = chances.deal * chances.calc

    if (devil_spawned and not devil_visited) or book_of_virtues then
        local tmp = chances.devil
        chances.devil = chances.angel
        chances.angel = tmp

        if book_of_virtues and angel_spawned then
            chances.devil = chances.angel * .375
            chances.angel = chances.angel - chances.devil
            return chances
        end
    end

    if devil_spawned and angel_spawned and not devil_item_taken then
        local tmp = chances.devil + chances.angel
        chances.devil = tmp / 2.0
        chances.angel = tmp / 2.0
    end

    return chances
end

function Stats.GetStats(player_entity, player_number)
    local stats = {}
    stats[Stats.Stat.SPEED] = Stats.Stat.GetStat(player_entity.MoveSpeed, Stats.Stat.SPEED, false)
    stats[Stats.Stat.FIRE_DELAY] = Stats.Stat.GetStat(30 / (player_entity.MaxFireDelay + 1), Stats.Stat.FIRE_DELAY, false)
    stats[Stats.Stat.DAMAGE] = Stats.Stat.GetStat(player_entity.Damage, Stats.Stat.DAMAGE, false)
    stats[Stats.Stat.RANGE] = Stats.Stat.GetStat(player_entity.TearRange / 40, Stats.Stat.RANGE, false)
    stats[Stats.Stat.SHOT_SPEED] = Stats.Stat.GetStat(player_entity.ShotSpeed, Stats.Stat.SHOT_SPEED, false)
    stats[Stats.Stat.LUCK] = Stats.Stat.GetStat(player_entity.Luck, Stats.Stat.LUCK, false)

    if player_number == 1 then
        stats[Stats.Stat.PLANETARIUM] = Stats.Stat.GetStat(game:GetLevel():GetPlanetariumChance() * 100, Stats.Stat.PLANETARIUM, true)

        local chances = Stats.GetDevilAngelChance()
        if chances.duality then
            stats[Stats.Stat.DEVIL] = Stats.Stat.GetStat(chances.devil * 100, Stats.Stat.DUALITY, true)
        else
            stats[Stats.Stat.DEVIL] = Stats.Stat.GetStat(chances.devil * 100, Stats.Stat.DEVIL, true)
            stats[Stats.Stat.ANGEL] = Stats.Stat.GetStat(chances.angel * 100, Stats.Stat.ANGEL, true)
        end
    end

    local oldStats = DATA.PLAYERS[player_number].Stats.Old
    for k, stat in pairs(stats) do
        local stat2 = oldStats[k]
        if stat2 and stat.Value ~= stat2.Value then
            local val = stat.Value - stat2.Value
            if DATA.PLAYERS[player_number].Stats.Updates[k] then
                val = DATA.PLAYERS[player_number].Stats.Updates[k].Value + val
            end
            DATA.PLAYERS[player_number].Stats.Updates[k] = {
                Value = val,
                Frames = mod.config.stats.text.update.frames,
            }
        end
    end

    return stats
end

local abs = math.abs
function Stats.Render(edge, edge_indexed, edge_multipliers, player_entity, player_number, pColor)
    local is_lower_text = abs(player_number) > 2
    local is_twin = player_number < 0
    local render_sprite = not is_lower_text and not is_twin

    local additional_offset = is_twin and mod.config.stats.text.twin_offset or Vector.Zero

    local edge_multipliers2 = Vector(edge_multipliers.X, edge_multipliers.Y)
    edge_multipliers2.Y = 1

    local edge2 = Vector(edge_indexed.X, edge.Y)

    local pos = edge2 + (mod.config.stats.pos * edge_multipliers2)
    local text_pos = edge2 + ((mod.config.stats.text.pos + additional_offset) * edge_multipliers2)

    if (abs(player_number) % 2) == 0 then
        pos = pos + mod.config.stats.mirrored_offset
        text_pos = text_pos + mod.config.stats.text.mirrored_offset
    end

    if is_lower_text then
        text_pos = text_pos + (mod.config.stats.text.lowered_offset * edge_multipliers2)
    end

    if not mod.config.stats.text.colors then pColor = {1, 1, 1, 0.5} end

    local stats = Stats.GetStats(player_entity, player_number)

    mod.Utils.CreateCallback(mod.Callbacks.PRE_STATS_RENDER, stats, player_entity, player_number)

    local updates = DATA.PLAYERS[player_number].Stats.Updates
    for i = Stats.Stat.SPEED, #stats - Stats.Stat.SPEED, 1 do
        Stats.Stat.Render(
            stats[i],
            pos + (mod.config.stats.offset * i),
            text_pos + (mod.config.stats.text.offset * i),
            render_sprite,
            pColor
        )

        if updates[i] then
            local color = KColor(1, 0, 0, 0.5)
            local value = updates[i].Value
            local prefix = ''

            if value > 0 then
                color = KColor(0, 1, 0, 0.5)
                prefix = '+'
            end

            local update_pos = text_pos + (mod.config.stats.text.offset * i) + (mod.config.stats.text.update.offset * edge_multipliers2)
            DATA.FONTS.stats:DrawStringScaled(
                prefix..string.format(stats[i].IsPercent and '%.1f%%' or '%.2f', value),
                update_pos.X, update_pos.Y,
                mod.config.stats.text.scale.X,
                mod.config.stats.text.scale.Y,
                color, 0, true
            )

            updates[i].Frames = updates[i].Frames - 1
            if updates[i].Frames < 1 or updates[i].Value == 0 then updates[i] = nil end
        end

    end

    DATA.PLAYERS[player_number].Stats.Old = stats
end
