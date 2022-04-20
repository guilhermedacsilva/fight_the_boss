function Spawn( entityKeyValues )
    thisEntity._thinkCounter = 0
    thisEntity._thinkCounterExplosion = -1
    thisEntity._thinkCounterExplosionRadius = 500
    thisEntity._thinkCounterExplosionDamage = 300
    thisEntity._thinkCounterExplosionPosition = 0
    thisEntity._spawnerVector = Entities:FindByName(nil, "spawner_center"):GetCenter()
    thisEntity:SetContextThink( "BossThink", BossThink, 3 )
end

function BossThink()
    if thisEntity:IsNull() or not thisEntity:IsAlive() then
        return nil
    elseif GameRules:IsGamePaused() then
        return 1
    end

    thisEntity._thinkCounter = thisEntity._thinkCounter + 1

    if thisEntity._thinkCounter % 5 == 0 then
        local vectorRandom = Vector(RandomInt(-500,500),RandomInt(-500,500),0)
		local enemy = CreateUnitByName("npc_frost_wolf", thisEntity._spawnerVector + vectorRandom, true, nil, nil, DOTA_TEAM_BADGUYS)
    end

    if thisEntity._thinkCounter % 7 == 0 then
        local cast_time = 2

        thisEntity._thinkCounterExplosionPosition = thisEntity:GetOrigin()
        AICore:CreateDangerCircle(thisEntity._thinkCounterExplosionPosition, thisEntity._thinkCounterExplosionRadius, cast_time)

        thisEntity._thinkCounterExplosion = thisEntity._thinkCounter + 2
    
    elseif thisEntity._thinkCounter == thisEntity._thinkCounterExplosion then
        

        local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
                            thisEntity._thinkCounterExplosionPosition,
                              nil,
                              thisEntity._thinkCounterExplosionRadius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
		for _,unit in pairs(units) do
			ApplyDamage({
				victim = unit,
				attacker = thisEntity,
				damage = thisEntity._thinkCounterExplosionDamage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = nil
			})
            local pIdx = ParticleManager:CreateParticle("particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl( pIdx, 0, unit:GetOrigin() )
            ParticleManager:ReleaseParticleIndex( pIdx )
		end

    end

    return 1
end
