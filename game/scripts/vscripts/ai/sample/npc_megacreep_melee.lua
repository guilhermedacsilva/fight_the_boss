function Spawn( entityKeyValues )
    thisEntity._abilityJump = thisEntity:FindAbilityByName( "npc_megacreep_melee_jump" )
    thisEntity:SetContextThink( "BossThink", BossThink, 3.5 )
end

function BossThink()
    if thisEntity:IsNull() or not thisEntity:IsAlive() then
        return nil
    end

    if thisEntity._abilityJump:IsFullyCastable() then
        AICore:CastAbilityNoTarget(thisEntity, thisEntity._abilityJump)
    end

    return 1
end
