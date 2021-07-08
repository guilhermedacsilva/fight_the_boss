require('game/floresta1')
require('game/floresta2')
require('game/dire1')

if SimpleAdventure == nil then
    SimpleAdventure = class({})
end

function SimpleAdventure:Init()
    if DEBUG_HEROES then
        if DEBUG_START_SCENE == 1 then
            Floresta1:Init()
        elseif DEBUG_START_SCENE == 2 then
            Floresta2:DebugScene()
        elseif DEBUG_START_SCENE == 3 then
            Dire1:DebugScene()
        end
    else
        for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
            if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS and PlayerResource:HasSelectedHero( nPlayerID ) then
                local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
                table.insert(HEROES, hero)
            end
        end
        Floresta1:Init()
    end
    GameRules:GetGameModeEntity():SetThink( "IsGameOver", self, 3 )
end

function SimpleAdventure:IsGameOver()
    for _,h in pairs(HEROES) do
        if h ~= nil and h:IsAlive() then
            return 2
        end
    end
    GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
    return nil
end

function SimpleAdventure:EnemiesInRange(targetVector, radius)
    local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
                  targetVector,
                  nil,
                  radius,
                  DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                  DOTA_UNIT_TARGET_ALL,
                  DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
                  FIND_ANY_ORDER,
                  false)
    return #units > 0
end

function SimpleAdventure:CreateEnemy(name, localVector, qnt)
    for i=1,qnt do
        CreateUnitByName(name, localVector, true, nil, nil, DOTA_TEAM_BADGUYS)
    end
end

function SimpleAdventure:StartNextScene(sceneObj)
    GameRules:GetGameModeEntity():SetThink( "Init", sceneObj, 3 )
end

function SimpleAdventure:LevelUp(scene)
    for _, hero in pairs (HEROES) do
        if not hero:IsAlive() then
            hero:RespawnUnit()
        end
        hero:ModifyGold(GOLD_TABLE[scene], true, 0)
        hero:AddExperience(100, 0, false, false)
    end
    self:RefreshAllUnits()
    EmitGlobalSound("Adventure.Coins")
end

function SimpleAdventure:RefreshAllUnits()
    local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
                  Vector(0,0,0),
                  nil,
                  FIND_UNITS_EVERYWHERE,
                  DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                  DOTA_UNIT_TARGET_ALL,
                  DOTA_UNIT_TARGET_FLAG_NONE,
                  FIND_ANY_ORDER,
                  false)
    for _, unit in pairs(units) do
        unit:SetHealth( unit:GetMaxHealth() )
        unit:SetMana( unit:GetMaxMana() )
    end
end
