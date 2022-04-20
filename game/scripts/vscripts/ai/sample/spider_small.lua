function Spawn( entityKeyValues )
    thisEntity:SetContextThink( "BossThink", BossThink, 1.5 )
end

function BossThink()
    if thisEntity:IsNull() or not thisEntity:IsAlive() then
        return nil
    end

    if thisEntity:GetHealth() == thisEntity:GetMaxHealth() then
        return 2
    end

    local units = AICore:BotFindEnemies(thisEntity:GetOrigin(), 600)
    if #units > 1 and RandomInt(1,2) == 1 then
        AICore:AttackTarget(thisEntity, units[RandomInt(2,#units)])
    end
    return 1.5
end
