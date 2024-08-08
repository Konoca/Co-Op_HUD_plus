local mod = CoopHUDplus
local DATA = mod.DATA

local Inventory = mod.Inventory

local InvSprite = Sprite()

Inventory.InventoryInfo = {
    [PlayerType.PLAYER_ISAAC_B] = function (player_entity)
        local max_slots, row_size = 8, 4
        if player_entity:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
            max_slots = 12
            row_size = 6
        end
        return max_slots, row_size, function(_, player_number) return DATA.PLAYERS[player_number].Inventory end
    end,

    [PlayerType.PLAYER_CAIN_B] = function (_)
        return 8, 4, function(player_entity, _) return player_entity:GetBagOfCraftingContent() end
    end,

    [PlayerType.PLAYER_XXX_B] = function (_)
        return 6, 6, function(player_entity, _)
            local inv = {}
            for i = 0, 6, 1 do
                table.insert(inv, player_entity:GetPoopSpell(i))
            end
            return inv
        end
    end,
}

Inventory.SpriteInfo = {
    [PlayerType.PLAYER_ISAAC_B] = function(inventory, i)
            InvSprite:Load(mod.PATHS.ANIMATIONS.inv, false)
            InvSprite:SetFrame('Idle', i - 1)
            if inventory[i] then InvSprite:ReplaceSpritesheet(2, inventory[i]) end
            InvSprite:LoadGraphics()
    end,

    [PlayerType.PLAYER_CAIN_B] = function(inventory, i)
        InvSprite:Load(mod.PATHS.ANIMATIONS.crafting, false)
        InvSprite:SetFrame('Idle', inventory[i] and inventory[i] or 0)
        InvSprite:LoadGraphics()
    end,

    [PlayerType.PLAYER_XXX_B] = function(inventory, i)
        InvSprite:Load(mod.PATHS.ANIMATIONS.poops, false)
        InvSprite:SetFrame(i == 1 and 'Idle' or 'IdleSmall', inventory[i])
        InvSprite:LoadGraphics()
    end,
}

Inventory.ExtraFunctions = {
    [PlayerType.PLAYER_CAIN_B] = function(edge_indexed, edge_multipliers, player_entity, player_number, _)
        local function GetResult(inventory)
            if #inventory ~= 8 then return nil end
            local itemconfig = Isaac:GetItemConfig()

            if (Game():GetLevel():GetCurses() & 64) == 64 and not mod.config.inventory.ignore_curse then
                return 'gfx/items/questionmark.png'
            end

            local id = player_entity:GetBagOfCraftingOutput()
            return id ~= 0 and itemconfig:GetCollectible(id).GfxFileName or 'gfx/items/questionmark.png'
        end

        local pos = edge_indexed + (mod.config.inventory.result_pos * edge_multipliers)

        InvSprite:SetFrame('Result', 0)
        InvSprite.FlipX = edge_multipliers.X == -1
        InvSprite.Color = Color(1, 1, 1, 0.5)

        local result = GetResult(DATA.PLAYERS[player_number])

        if result then
            InvSprite:ReplaceSpritesheet(1, result)
        end

        InvSprite:LoadGraphics()
        InvSprite:Render(pos)

        InvSprite.FlipX = false
        InvSprite.Color = Color(1, 1, 1, 1)
    end
}

function Inventory.GetInventoryInfo(player_entity, pType)
    if Inventory.InventoryInfo[pType] then return true, Inventory.InventoryInfo[pType](player_entity) end
    return false, 0, 0, nil
end

function Inventory.Render(edge_indexed, edge_multipliers, player_entity, player_number, pType)
    local display, max_slots, row_size, get_inv = Inventory.GetInventoryInfo(player_entity, pType)
    if not display or not get_inv then return end

    local pos = Vector(0, 0)
    local offset = Vector(0, 0)
    local edge = edge_indexed + (mod.config.inventory.pos * edge_multipliers)

    local sprite_func = Inventory.SpriteInfo[pType]
    local extra_func = Inventory.ExtraFunctions[pType]

    local inventory = get_inv(player_entity, player_number)

    local row = 0
    for i = 1, max_slots, 1 do
        if i % (row_size + 1) == 0 and i ~= 1 then
            row = row + 1
            offset.X = 0
            offset.Y = offset.Y + mod.config.inventory.spacing.Y
        end

        pos = edge + (offset * edge_multipliers)

        sprite_func(inventory, i)
        InvSprite:Render(pos)

        offset.X = offset.X + mod.config.inventory.spacing.X
    end

    if extra_func then extra_func(edge_indexed, edge_multipliers, player_entity, player_number, pType) end
end

function Inventory.Add(player_entity, player, item)
    local display, max_slots, _ = Inventory.GetInventoryInfo(player_entity, player_entity:GetPlayerType())
    if not display then return end

    if #player.Inventory == max_slots then
        player.Inventory[1] = item.GfxFileName
        return
    end
    table.insert(player.Inventory, item.GfxFileName)
end

function Inventory.Shift(player)
    for _ = 1, #player.Inventory - 1, 1 do
        table.insert(player.Inventory, 1, table.remove(player.Inventory, #player.Inventory) )
    end
end
