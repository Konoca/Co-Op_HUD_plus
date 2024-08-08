-- Possible code to append to line 189 of hud_helper
-- and not (CoopHUDplus or {}).IS_HUD_VISIBLE

local mod = CoopHUDplus

local Health = mod.Health

local function EpiphanyHudHelper(player_entity, _, edges, edge_multipliers)
    for _, v in pairs(HudHelper.HUD_ELEMENTS) do
        if v.Condition(player_entity) and v.Name ~= 'TR Isaac Inventory' then
            v.OnRender(player_entity, edges + (mod.config.mods.EPIPHANY.hud_element_pos * edge_multipliers))
        end
    end
end


local function EpiphanyLostHealth(hearts, pEntity, _)
    if not mod.IS_HUD_VISIBLE or Game():GetLevel():GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN > 0 then return end
    if pEntity:IsDead() or pEntity:IsCoopGhost() or pEntity:GetPlayerType() ~= Epiphany.PlayerType.LOST then return end

    hearts[1].heart:Load("gfx/ui/lost_health_hud.anm2", true)
    hearts[1].heart:SetFrame("Idle", 0)

    if pEntity:GetData().EP_ShouldHaveMantleCostume then
		hearts[1].heart:SetFrame("Idle", 1)
	end
end

local function EpiphanyKeeperHealth(hearts, pEntity, _)
    if not mod.IS_HUD_VISIBLE or Game():GetLevel():GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN > 0 then return end
    if pEntity:IsDead() or pEntity:IsCoopGhost() or pEntity:GetPlayerType() ~= Epiphany.PlayerType.KEEPER then return end

    local function createSprite()
        local MoneyHealthHud = Sprite()
        MoneyHealthHud:Load("gfx/ui/money_health_hud.anm2", true)
        MoneyHealthHud:SetFrame("HUD", 0)
        MoneyHealthHud.Color = Color(1, 1, 1)
        if pEntity:GetSoulHearts() == 1 then
            local interval = (math.ceil((Game():GetFrameCount() + 1) / 45) * 45 - (Game():GetFrameCount() + 1))
            local alpha = math.max((interval - 30) / 15, 0)
            MoneyHealthHud.Color = Color(1, 1, 1, 1, alpha / 2)
        else
            if pEntity:GetData().TRK_HPFlashEpoch and Game():GetFrameCount() - pEntity:GetData().TRK_HPFlashEpoch <= 5 then
                MoneyHealthHud.Color = Color(1, 1, 1, 1, 0.25, 0.25, 0.25)
            end
        end
        return MoneyHealthHud
    end

    local COIN_MAX_LOSS = 20

    local Money = pEntity:GetNumCoins()
	local MoneyByDollar = math.floor(math.max(Money - 1, 0) / 100)
	local MoneyByDollarMod = math.max(Money - 1, 0) % 100
	local MoneyByDDime = math.floor(MoneyByDollarMod / COIN_MAX_LOSS)
	if Money == 0 then
		FullGoldHeart = 0
		HalfGoldHeart = 1
	else
		FullGoldHeart = 1
		HalfGoldHeart = 0
	end
	local MoneyInCash = {
		{ HalfGoldHeart, "Half Gold Heart" },
		{ FullGoldHeart, "Full Gold Heart" },
		{ MoneyByDollar, "Dollars" },
		{ MoneyByDDime, "Double Dimes" },
	}

    for i = 1, #hearts, 1 do
        hearts[i] = nil
    end

    for i = 1, #MoneyInCash do
        for _ = 1, MoneyInCash[i][1] do
            local heart = createSprite()
            heart:SetFrame("HUD", i)
            table.insert(hearts, Health.Heart.GetSpriteBasic(heart, nil, nil))
        end
    end
    for _ = 1, pEntity:GetBrokenHearts() do
        local heart = createSprite()
        if pEntity:HasCollectible(416) then
            heart:SetFrame("HUD", 8)
        else
            heart:SetFrame("HUD", 7)
        end
        table.insert(hearts, Health.Heart.GetSpriteBasic(heart, nil, nil))
    end
    local heart = createSprite()
    local player_save = Epiphany:PlayerRunSave(pEntity)
    if player_save.TRK_HPMantle and player_save.TRK_HPMantle == true then
        heart:SetFrame("HUD", 6)
    else
        heart:SetFrame("HUD", 5)
    end
    table.insert(hearts, Health.Heart.GetSpriteBasic(heart, nil, nil))
end

local function EpiphanyMultitool(misc, _, _, _)
    local run_save = Epiphany:RunSave()

    if run_save["MultitoolCount"] and run_save["MultitoolCount"] < 1 then
		return
	end
	if run_save["HUDDifference"] then
        misc[4].Anim = 'gfx/ui/multitoolhud.anm2'
	end
end

local isaac = require('scripts.compatabilities.epiphany.isaac')
local chargebars = require('scripts.compatabilities.epiphany.chargebars')
local function AddCallbacks()
    local modID = Epiphany.Name
    mod.Utils.AddCallback(modID, mod.Callbacks.POST_PLAYER_RENDER, EpiphanyHudHelper)
    mod.Utils.AddCallback(modID, mod.Callbacks.PRE_HEALTH_RENDER, EpiphanyLostHealth)
    mod.Utils.AddCallback(modID, mod.Callbacks.PRE_HEALTH_RENDER, EpiphanyKeeperHealth)
    mod.Utils.AddCallback(modID, mod.Callbacks.PRE_MISC_RENDER, EpiphanyMultitool)

    mod.Utils.AddCallback(modID, mod.Callbacks.POST_PLAYER_RENDER, isaac.EpiphanyIsaacFunc)
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, chargebars.EpiphanySamsonCharge, 0)
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, chargebars.EpiphanyCainCharge, 0)
end
return AddCallbacks
