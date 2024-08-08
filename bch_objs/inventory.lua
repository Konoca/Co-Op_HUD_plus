function Better_Coop_HUD.Inventory.new(player_entity)
    local self = setmetatable({}, Better_Coop_HUD.Inventory)

    self.player_entity = player_entity
    self.inv = {}
    self.display = false

    self.ptype = player_entity:GetPlayerType()
    if self.ptype == PlayerType.PLAYER_CAIN_B then
        self.inv = EID.BoC.BagItems
        self.anim = Better_Coop_HUD.PATHS.ANIMATIONS.crafting
        self.display = true
        self.result = self:getResult()
    end

    if self.ptype == PlayerType.PLAYER_ISAAC_B then
        self.inv = {}
        -- TODO get isaac items, store sprite path

        self.anim = Better_Coop_HUD.PATHS.ANIMATIONS.inv
        self.display = true
    end

    self.sprites = self:getSprites()

    return self
end

function Better_Coop_HUD.Inventory:getSprites()
    if not self.display then return end
    local sprites = {}
    for i = 1, 8, 1 do
        local s = Sprite()

        if self.ptype == PlayerType.PLAYER_CAIN_B then
            s:Load(self.anim, true)
            s:SetFrame('Idle', self.inv[i] and self.inv[i] or 0)
        end

        if self.ptype == PlayerType.PLAYER_ISAAC_B then
            s:Load(self.anim, false)
            s:SetFrame('Idle', i - 1)
            if self.inv[i] then s:ReplaceSpritesheet(2, self.inv[i]) end
            s:LoadGraphics()
        end

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
    for i = 1, 8, 1 do
        if i % 5 == 0 and i ~= 1 then
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
