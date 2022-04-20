if Dire1 == nil then
    Dire1 = class({})
    Dire1.finished = false
end

function Dire1:Init()
    self.shop3 = Entities:FindByName(nil, "shop3"):GetAbsOrigin()

    local spawnerDire1 = Entities:FindByName(nil, "spawner_dire1"):GetAbsOrigin()
    local spawnerDire2 = Entities:FindByName(nil, "spawner_dire2"):GetAbsOrigin()
    local spawnerDire3 = Entities:FindByName(nil, "spawner_dire3"):GetAbsOrigin()
    local spawnerDire4 = Entities:FindByName(nil, "spawner_dire4"):GetAbsOrigin()
    local spawnerDire5 = Entities:FindByName(nil, "spawner_dire5"):GetAbsOrigin()
    local spawnerSpider1 = Entities:FindByName(nil, "spawner_spider1"):GetAbsOrigin()
    local spawnerSpider2 = Entities:FindByName(nil, "spawner_spider2"):GetAbsOrigin()

    SimpleAdventure:CreateEnemy("npc_unit_spider_bomb", spawnerDire1, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_bomb", spawnerDire2, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_small", spawnerDire2, 3)
    SimpleAdventure:CreateEnemy("npc_unit_spider_bomb", spawnerDire3, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_mecha", spawnerDire3, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_small", spawnerDire3, 2)
    SimpleAdventure:CreateEnemy("npc_unit_spider_radioactive", spawnerDire4, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_mecha", spawnerDire4, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_small", spawnerDire4, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_brood", spawnerDire5, 1)

    CreateItemOnPositionSync(spawnerSpider1, CreateItem("item_flask_datadriven", nil, nil))
    SimpleAdventure:CreateEnemy("npc_unit_spider_bomb", spawnerSpider1, 1)

    SimpleAdventure:CreateEnemy("npc_unit_spider_small", spawnerSpider2, 1)
    SimpleAdventure:CreateEnemy("npc_unit_spider_bomb", spawnerSpider2, 1)
    CreateItemOnPositionSync(Vector(spawnerSpider2.x-100, spawnerSpider2.y-100, spawnerSpider2.z),
        CreateItem("item_flask_datadriven", nil, nil))

    GameRules:GetGameModeEntity():SetThink( "CheckFinished", self, 15 )
end

function Dire1:CheckFinished()
    local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
                              self.shop3,
                              nil,
                              500,
                              DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
    if #units > 0 then
        self:EndLevel()
        return nil
    end
    return 2
end


function Dire1:EndLevel()
    if not self.finished then
        self.finished = true
        SimpleAdventure:LevelUp(3)
    end
end


function Dire1:DebugScene()
    local moveTo = Entities:FindByName(nil, "goat9"):GetAbsOrigin()
    local pos = 1
    for _, hero in pairs(HEROES) do
        hero:SetOrigin(Vector(moveTo.x + pos * 100, moveTo.y - 150, 128))
        pos = pos + 1
    end
    DEBUG_REAL_HERO:SetOrigin(Vector(moveTo.x + pos * 100, moveTo.y - 150, 128))

    self:Init()
end
