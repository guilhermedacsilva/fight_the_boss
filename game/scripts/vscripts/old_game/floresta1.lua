if Floresta1 == nil then
    Floresta1 = class({})
end

function Floresta1:Init()
    Floresta1:GiveStartItems()
    local spawnerVector = Entities:FindByName(nil, "spawner_area_goat"):GetAbsOrigin()
    self.goat = CreateUnitByName("npc_unit_delivery_goat", spawnerVector, true, nil, nil, DOTA_TEAM_GOODGUYS)
    self.goatTargetNum = 1
    self.goatDestiny = Entities:FindByName(nil, "goat1")
    self.spawnerTop1 = Entities:FindByName(nil, "spawner_bandit_top1"):GetAbsOrigin()
    self.spawnerBot1 = Entities:FindByName(nil, "spawner_bandit_bot1"):GetAbsOrigin()
    self.spawnerTop2 = Entities:FindByName(nil, "spawner_bandit_top2"):GetAbsOrigin()
    self.spawnerBot2 = Entities:FindByName(nil, "spawner_bandit_bot2"):GetAbsOrigin()
    self.spawnerTop3 = Entities:FindByName(nil, "spawner_bandit_top3"):GetAbsOrigin()
    self.spawnerBot3 = Entities:FindByName(nil, "spawner_bandit_bot3"):GetAbsOrigin()
    GameRules:GetGameModeEntity():SetThink( "MoveGoat", self, 5 )
    GameRules:GetGameModeEntity():SetThink( "SpawnBandits", self, 7 )

    if DEBUG_HEROES then
        local start_area = Entities:FindByName(nil, "spawner_area_goat"):GetAbsOrigin()
        local pos = 1
        for _, hero in pairs(HEROES) do
            hero:SetOrigin(Vector(start_area.x - 150, start_area.y + pos * 100,128))
            pos = pos + 1
        end
    end
end

function Floresta1:GiveStartItems()
    for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
        if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS and PlayerResource:HasSelectedHero( nPlayerID ) then
            local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
            hero:AddItemByName("item_flask_datadriven")
        end
    end
end

function Floresta1:MoveGoat()
    local enemiesNear = SimpleAdventure:EnemiesInRange(self.goat:GetAbsOrigin(), 850)

    if self.goat == nil or self.goat == none or not self.goat:IsAlive() then
        GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
        return nil

    elseif self.goat:IsMoving() then
        if enemiesNear then
            ExecuteOrderFromTable({
              UnitIndex = self.goat:entindex(),
              OrderType = DOTA_UNIT_ORDER_HOLD_POSITION,
              Queue = false
            })
        end

    elseif CalcDistanceBetweenEntityOBB(self.goat, self.goatDestiny) <= 10 then
        self.goatTargetNum = self.goatTargetNum + 1
        if self.goatTargetNum == 4 then
            self:EndLevel()
            return nil
        end
        self:SpawnBandits()
        self.goatDestiny = Entities:FindByName(nil, "goat" .. self.goatTargetNum)
        ExecuteOrderFromTable({
          UnitIndex = self.goat:entindex(),
          OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
          Position = self.goatDestiny:GetAbsOrigin(),
          Queue = true
        })

    elseif not enemiesNear then
        ExecuteOrderFromTable({
          UnitIndex = self.goat:entindex(),
          OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
          Position = self.goatDestiny:GetAbsOrigin(),
          Queue = true
        })
    end

    return 1
end

function Floresta1:SpawnBandits()
    if self.goatTargetNum == 1 then
        SimpleAdventure:CreateEnemy("npc_unit_kobold_1", self.spawnerTop1, 2)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_1", self.spawnerBot1, 2)
    elseif self.goatTargetNum == 2 then
        SimpleAdventure:CreateEnemy("npc_unit_kobold_1", self.spawnerTop1, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_1", self.spawnerBot1, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerTop2, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerBot2, 1)
    elseif self.goatTargetNum == 3 then
        SimpleAdventure:CreateEnemy("npc_unit_kobold_1", self.spawnerTop1, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_1", self.spawnerBot1, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerTop2, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerBot2, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_3", self.spawnerTop3, 1)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_3", self.spawnerBot3, 1)
    end
    return nil
end

function Floresta1:EndLevel()
    local v = Entities:FindByName(nil, "tree_path_left"):GetAbsOrigin()
    GridNav:DestroyTreesAroundPoint(v, 400, false)
    SimpleAdventure:LevelUp(1)
    SimpleAdventure:StartNextScene(Floresta2)
end
