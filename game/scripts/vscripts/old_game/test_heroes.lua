HEROES = {}
DEBUG_START_SCENE = 1

local hPlayer = PlayerResource:GetPlayer(0)
local heroItems = {}
local heroAbilities = {}

local hero = 0
hero = CreateHeroForPlayer("npc_dota_hero_dragon_knight", hPlayer)
HEROES["0"] = hero
heroAbilities["0"] = {0,1,0}
heroItems["0"] = {
    { ["name"] = "item_wood_shield_datadriven", ["cost"] = 100}
}

--[[
hero = CreateHeroForPlayer("npc_dota_hero_mars", hPlayer)
HEROES["0"] = hero
heroAbilities["0"] = {0,3,0}
heroItems["0"] = {
    { ["name"] = "item_wood_shield_datadriven", ["cost"] = 100}
}
]]--

hero = CreateHeroForPlayer("npc_dota_hero_windrunner", hPlayer)
HEROES["1"] = hero
heroAbilities["1"] = {0,2,0}
heroItems["1"] = {
    { ["name"] = "item_claws_datadriven", ["cost"] = 100}
}

hero = CreateHeroForPlayer("npc_dota_hero_lina", hPlayer)
HEROES["2"] = hero
heroAbilities["2"] = {0,2,0}
heroItems["2"] = {
    { ["name"] = "item_claws_datadriven", ["cost"] = 100}
}

local goldTotal = 0
for i=1,DEBUG_START_SCENE do
    goldTotal = goldTotal + GOLD_TABLE[i]
end
for heroKey, hero in pairs(HEROES) do
    hero:SetControllableByPlayer(0, true)
    hero:AddItemByName("item_flask_datadriven")

    -- LEVEL UP AND CHOOSE SKILLS
    hero:AddExperience(100 * (DEBUG_START_SCENE - 1), 0, false, false)
    for i = 1, DEBUG_START_SCENE do
        local abilityIdx = heroAbilities[heroKey][i]
        if abilityIdx == nil then
            break
        end
        local abilityHandle = hero:GetAbilityByIndex(abilityIdx)
        hero:UpgradeAbility(abilityHandle)
    end

    -- ITEMS
    local gold = goldTotal
    for _, item in pairs(heroItems[heroKey]) do
        if (gold < item["cost"]) then
            break
        end
        gold = gold - item["cost"]
        hero:AddItemByName(item["name"])
    end
end

hero = PlayerResource:GetSelectedHeroEntity( 0 )
DEBUG_REAL_HERO = hero
--hero:ForceKill(false)
