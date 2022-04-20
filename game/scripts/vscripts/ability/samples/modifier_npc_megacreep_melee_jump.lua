modifier_npc_megacreep_melee_jump = class({})

function modifier_npc_megacreep_melee_jump:IsHidden()
	return true
end

function modifier_npc_megacreep_melee_jump:IsPurgable()
	return false
end

function modifier_npc_megacreep_melee_jump:OnCreated( kv )
	if IsServer() then
		self:StartIntervalThink( self:GetAbility():GetSpecialValueFor( "cast_time" ) )
	end
end

function modifier_npc_megacreep_melee_jump:OnIntervalThink()
	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle( "particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector(self:GetAbility():GetSpecialValueFor( "radius" ),0,0) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )

		local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
                              self:GetCaster():GetOrigin(),
                              nil,
                              self:GetAbility():GetSpecialValueFor( "radius" ),
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
		for _,unit in pairs(units) do
			unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_hero_stunned", { duration = self:GetAbility():GetSpecialValueFor( "stun_duration" ) })
			ApplyDamage({
				victim = unit,
				attacker = self:GetCaster(),
				damage = self:GetAbility():GetSpecialValueFor( "damage" ),
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self
			})
		end
		UTIL_Remove( self:GetParent() )
	end
end
