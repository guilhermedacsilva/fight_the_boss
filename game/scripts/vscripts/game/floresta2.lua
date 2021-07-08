if Floresta2 == nil then
    Floresta2 = class({})
end

function Floresta2:Init()
    local spawnerVector = Entities:FindByName(nil, "spawner_area_goat"):GetAbsOrigin()
    self.goat = Floresta1.goat
    self.goatTargetNum = 4
    self.goatDestiny = Entities:FindByName(nil, "goat4")
    self.spawnerGoat4 = Entities:FindByName(nil, "goat4"):GetAbsOrigin()
    self.spawnerGoat5 = Entities:FindByName(nil, "goat5"):GetAbsOrigin()
    self.spawnerGoat6 = Entities:FindByName(nil, "goat6"):GetAbsOrigin()
    self.spawnerGoat7 = Entities:FindByName(nil, "goat7"):GetAbsOrigin()
    self.spawnerGoat8 = Entities:FindByName(nil, "goat8"):GetAbsOrigin()
    self.spawnerWolf1 = Entities:FindByName(nil, "spawner_wolf1"):GetAbsOrigin()
    self.spawnerWolf2 = Entities:FindByName(nil, "spawner_wolf2"):GetAbsOrigin()
    self.spawnerWolf3 = Entities:FindByName(nil, "spawner_wolf3"):GetAbsOrigin()
    GameRules:GetGameModeEntity():SetThink( "MoveGoat", self, 1 )
    GameRules:GetGameModeEntity():SetThink( "SpawnBandits", self, 13 )
end

function Floresta2:MoveGoat()
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
        if self.goatTargetNum == 10 then
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

function Floresta2:SpawnBandits()
    if self.goatTargetNum == 4 then
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerGoat4, 3)
        SimpleAdventure:CreateEnemy("npc_unit_gnoll", self.spawnerGoat4, 1)

        SimpleAdventure:CreateEnemy("npc_unit_wolf", self.spawnerWolf1, 3)
        CreateItemOnPositionSync(Vector(self.spawnerWolf1.x-100, self.spawnerWolf1.y, self.spawnerWolf1.z), CreateItem("item_flask_datadriven", nil, nil))

        SimpleAdventure:CreateEnemy("npc_unit_wolf", self.spawnerWolf2, 1)
        CreateItemOnPositionSync(Vector(self.spawnerWolf2.x-100, self.spawnerWolf2.y-100, self.spawnerWolf2.z), CreateItem("item_clarity_datadriven", nil, nil))

        SimpleAdventure:CreateEnemy("npc_unit_wolf", self.spawnerWolf3, 3)
        CreateItemOnPositionSync(Vector(self.spawnerWolf3.x+100, self.spawnerWolf3.y+100, self.spawnerWolf3.z), CreateItem("item_flask_datadriven", nil, nil))
    elseif self.goatTargetNum == 5 then
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerGoat5, 2)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_3", self.spawnerGoat5, 2)
        SimpleAdventure:CreateEnemy("npc_unit_gnoll", self.spawnerGoat5, 2)
    elseif self.goatTargetNum == 6 then
        SimpleAdventure:CreateEnemy("npc_unit_kobold_2", self.spawnerGoat6, 2)
        SimpleAdventure:CreateEnemy("npc_unit_kobold_3", self.spawnerGoat6, 2)
        SimpleAdventure:CreateEnemy("npc_unit_gnoll", self.spawnerGoat6, 2)
    elseif self.goatTargetNum == 7 then
        SimpleAdventure:CreateEnemy("npc_unit_ogre", self.spawnerGoat7, 2)
        SimpleAdventure:CreateEnemy("npc_unit_gnoll", self.spawnerGoat7, 3)
    elseif self.goatTargetNum == 8 then
        SimpleAdventure:CreateEnemy("npc_unit_ogre_big", self.spawnerGoat8, 1)
    end
    return nil
end

function Floresta2:EndLevel()
    SimpleAdventure:LevelUp(2)
    SimpleAdventure:StartNextScene(Dire1)
end


function Floresta2:DebugScene()
    local moveTo = Entities:FindByName(nil, "goat3"):GetAbsOrigin()
    Floresta1.goat = CreateUnitByName("npc_unit_delivery_goat", moveTo, true, nil, nil, DOTA_TEAM_GOODGUYS)
    local v = Entities:FindByName(nil, "tree_path_left"):GetAbsOrigin()
    GridNav:DestroyTreesAroundPoint(v, 400, false)

    local pos = 1
    for _, hero in pairs(HEROES) do
        hero:SetOrigin(Vector(moveTo.x + pos * 100, moveTo.y - 150, 128))
        pos = pos + 1
    end
    DEBUG_REAL_HERO:SetOrigin(moveTo)

    self:Init()
end
