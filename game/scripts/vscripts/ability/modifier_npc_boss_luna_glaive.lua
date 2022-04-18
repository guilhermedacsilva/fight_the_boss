modifier_npc_boss_luna_glaive = class({})

function modifier_npc_boss_luna_glaive:IsHidden()
	return true
end

function modifier_npc_boss_luna_glaive:IsPurgable()
	return false
end

function modifier_npc_boss_luna_glaive:OnCreated( kv )
	if IsServer() then
		self.luna_glaive_damage = self:GetAbility():GetSpecialValueFor( "damage" )
	end
end

function modifier_npc_boss_luna_glaive:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_npc_boss_luna_glaive:OnAttackLanded(params)
	local caster = self:GetCaster()
	if IsServer() and params.attacker == caster then
		local attackTarget = params.target
		
		local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
                              Vector(0,0,0),
                              nil,
                              FIND_UNITS_EVERYWHERE,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)

		if #units > 1 then
			local projTarget = nil
			while projTarget == nil do
				projTarget = units[RandomInt(1, #units)]
				if projTarget == attackTarget then
					projTarget = nil
				end
			end

			local info = 
			{
				Target = projTarget,
				Source = attackTarget,
				Ability = self:GetAbility(),	
				EffectName = "particles/econ/items/luna/luna_ti9_weapon/luna_ti9_moon_glaive_bounce.vpcf",
				iMoveSpeed = 900,
				vSourceLoc= attackTarget:GetAbsOrigin(),          -- Optional (HOW)
				bDrawsOnMinimap = false,                          -- Optional
				bDodgeable = false,                                -- Optional
				bIsAttack = true,                                -- Optional
				bVisibleToEnemies = true,                         -- Optional
				bReplaceExisting = false,                         -- Optional
				flExpireTime = GameRules:GetGameTime() + 10,      -- Optional but recommended
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
			}
			projectile = ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end
