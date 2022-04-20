HEROES = {}
INITIAL_ROUND = 2
DEBUG_QNT_HEROES = 1

local hPlayer = PlayerResource:GetPlayer(0)
local heroItems = {}
local heroAbilities = {}

local hero = 0
hero = CreateHeroForPlayer("npc_dota_hero_omniknight", hPlayer)
HEROES["0"] = hero
heroAbilities["0"] = {0,2,0,2}

if DEBUG_QNT_HEROES >= 2 then
    hero = CreateHeroForPlayer("npc_dota_hero_windrunner", hPlayer)
    HEROES["1"] = hero
    heroAbilities["1"] = {0,1,0,1}
end

if DEBUG_QNT_HEROES >= 3 then
    hero = CreateHeroForPlayer("npc_dota_hero_brewmaster", hPlayer)
    HEROES["2"] = hero
    heroAbilities["2"] = {0,1,0,1}
end

for heroKey, hero in pairs(HEROES) do
    hero:SetControllableByPlayer(0, true)
    hero:AddItemByName("item_flask_datadriven")
    hero:SetOrigin(Vector(300*(heroKey-1),-500,0))

    -- LEVEL UP AND CHOOSE SKILLS
    hero:AddExperience(100 * (INITIAL_ROUND - 1), 0, false, false)
    for i = 1, INITIAL_ROUND do
        local abilityIdx = heroAbilities[heroKey][i]
        if abilityIdx == nil then
            break
        end
        local abilityHandle = hero:GetAbilityByIndex(abilityIdx)
        hero:UpgradeAbility(abilityHandle)
    end
end

hero = PlayerResource:GetSelectedHeroEntity( 0 )
--hero = PlayerResource:GetAssignedHero()
DEBUG_REAL_HERO = hero
--hero:ForceKill(false)
