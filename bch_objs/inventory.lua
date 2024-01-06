Better_Coop_HUD.Inventory.handle_player = {
    [PlayerType.PLAYER_ISAAC_B] = function (self)
        if self.player_entity:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
            self.max_slots = 12
            self.row_size = 6
        end
        self.display = true

        self.sprite_func = function (s, i)
            s:Load(Better_Coop_HUD.PATHS.ANIMATIONS.inv, false)
            s:SetFrame('Idle', i - 1)
            if self.inv[i] then s:ReplaceSpritesheet(2, self.inv[i]) end
            s:LoadGraphics()
        end
    end,

    [PlayerType.PLAYER_CAIN_B] = function (self)
        self.inv = EID.BoC.BagItems
        self.display = true
        self.result = self:getResult()

        self.sprite_func = function (s, i)
            s:Load(Better_Coop_HUD.PATHS.ANIMATIONS.crafting, true)
            s:SetFrame('Idle', self.inv[i] and self.inv[i] or 0)
        end
    end,

    [PlayerType.PLAYER_XXX_B] = function (self)
        self.inv = {}

        self.max_slots = 6
        self.row_size = 6
        self.display = true


        for i = 0, self.max_slots, 1 do
            table.insert(self.inv, self.player_entity:GetPoopSpell(i))
        end

        self.sprite_func = function (s, i)
            s:Load(Better_Coop_HUD.PATHS.ANIMATIONS.poops, false)
            local anim = i == 1 and 'Idle' or 'IdleSmall'
            s:SetFrame(anim, self.inv[i])
            s:LoadGraphics()
        end
    end,
}

function Better_Coop_HUD.Inventory.new(player_entity, previous_player)
    local self = setmetatable({}, Better_Coop_HUD.Inventory)

    self.player_entity = player_entity
    self.previous_player = previous_player
    self.inv = previous_player and previous_player.inventory.inv or {}
    self.display = false

    self.max_slots = 8
    self.row_size = 4

    self.sprite_func = nil

    local func = Better_Coop_HUD.Inventory.handle_player[player_entity:GetPlayerType()]
    if func then func(self) end

    self.sprites = self:getSprites()

    return self
end

function Better_Coop_HUD.Inventory:getSprites()
    if not self.display then return end
    if not self.sprite_func then return end

    local sprites = {}
    for i = 1, self.max_slots, 1 do
        local s = Sprite()
        self.sprite_func(s, i)
        table.insert(sprites, s)
    end

    return sprites
end

function Better_Coop_HUD.Inventory:getResult()
    if #self.inv ~= 8 then return nil end
    local itemconfig = Isaac:GetItemConfig()

    if (Game():GetLevel():GetCurses() & 64) == 64 and not Better_Coop_HUD.config.inventory.ignore_curse then
        return itemconfig:GetCollectible(0).GfxFileName
    end

    local id = EID:calculateBagOfCrafting(self.inv)
    return itemconfig:GetCollectible(id).GfxFileName
end

function Better_Coop_HUD.Inventory:render(edge_indexed, edge_multipliers)
    if not self.display then return end

    local pos = Vector(0, 0)
    local offset = Vector(0, 0)
    local edge = edge_indexed + (Better_Coop_HUD.config.inventory.pos * edge_multipliers)

    local row = 0
    for i = 1, self.max_slots, 1 do
        if i % (self.row_size + 1) == 0 and i ~= 1 then
            row = row + 1
            offset.X = 0
            offset.Y = offset.Y + Better_Coop_HUD.config.inventory.spacing.Y
        end

        pos = edge + (offset * edge_multipliers)

        self.sprites[i]:Render(pos)

        offset.X = offset.X + Better_Coop_HUD.config.inventory.spacing.X
    end

    self:renderResult(edge_indexed, edge_multipliers)

end

function Better_Coop_HUD.Inventory:renderResult(edge_indexed, edge_multipliers)
    if self.ptype ~= PlayerType.PLAYER_CAIN_B then return end

    local pos = edge_indexed + (Better_Coop_HUD.config.inventory.result_pos * edge_multipliers)
    local sprite = Sprite()
    sprite:Load(Better_Coop_HUD.PATHS.ANIMATIONS.crafting, false)
    sprite:SetFrame('Result', 0)

    if self.result then
        sprite:ReplaceSpritesheet(1, self.result)
    end

    sprite:LoadGraphics()
    sprite:Render(pos)
end

function Better_Coop_HUD.Inventory:addCollectible(item)
    if #self.inv == self.max_slots then
        self.inv[1] = item.GfxFileName
        return
    end
    table.insert(self.inv, item.GfxFileName)
end

function Better_Coop_HUD.Inventory:shiftCollectibles()
    for i = 1, #self.inv - 1, 1 do
        table.insert(self.inv, 1, table.remove(self.inv, #self.inv) )
    end
end
