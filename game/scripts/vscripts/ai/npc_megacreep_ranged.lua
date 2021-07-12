function Spawn( entityKeyValues )
    thisEntity._abilityCrystal = thisEntity:FindAbilityByName( "npc_megacreep_ranged_crystal" )
    thisEntity:SetContextThink( "BossThink", BossThink, 3.5 )
end

function BossThink()
    if thisEntity:IsNull() or not thisEntity:IsAlive() then
        return nil
    end

    if thisEntity._abilityCrystal:IsFullyCastable() then
        AICore:CastAbilityNoTarget(thisEntity, thisEntity._abilityCrystal)
        return 0.9
    end

    return 1
end
