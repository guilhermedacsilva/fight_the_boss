function Spawn( entityKeyValues )
    thisEntity._abilityWeb = thisEntity:FindAbilityByName( "spider_brood_web_datadriven" )
    thisEntity._abilitySummon = thisEntity:FindAbilityByName( "spider_brood_summon_datadriven" )
    thisEntity._attackFar = false
    thisEntity:SetContextThink( "BossThink", BossThink, 2 )
end

function BossThink()
    if thisEntity:IsNull() or not thisEntity:IsAlive() then
        return nil
    end

    if thisEntity:GetHealth() == thisEntity:GetMaxHealth() then
        return 2
    end

    if thisEntity._abilitySummon:IsFullyCastable() then
        AICore:CastAbilityNoTarget(thisEntity, thisEntity._abilitySummon)
        return 0.5

    elseif thisEntity._abilityWeb:IsFullyCastable() then
        AICore:CastAbilityPosition(thisEntity, thisEntity._abilityWeb, thisEntity:GetAbsOrigin())
        thisEntity._attackFar = true
        return 2

    elseif thisEntity._attackFar then
        thisEntity._attackFar = false
        local units = AICore:BotFindEnemies(thisEntity:GetAbsOrigin(), 600)
        if #units > 1 then
            AICore:AttackTarget(thisEntity, units[#units])
        end

    else
        local units = AICore:BotFindEnemies(thisEntity:GetAbsOrigin(), 600)
        if #units > 0 then
            AICore:AttackTarget(thisEntity, units[RandomInt(1,#units)])
        end
        return 2

    end

    return 1
end
