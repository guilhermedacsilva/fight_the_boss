modifier_npc_megacreep_ranged_crystal = class({})

function modifier_npc_megacreep_ranged_crystal:IsHidden()
	return true
end

function modifier_npc_megacreep_ranged_crystal:IsPurgable()
	return false
end

function modifier_npc_megacreep_ranged_crystal:OnCreated( kv )
	if IsServer() then
		self.crystal_index = ParticleManager:CreateParticle( "particles/ring_crystal.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( self.crystal_index, 0, self:GetParent():GetOrigin() )
		self.crystal_damage = self:GetAbility():GetSpecialValueFor( "damage" )
		self.crystal_radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self.crystal_caster = self:GetCaster()
		self.crystal_position = self:GetParent():GetOrigin()
		self:StartIntervalThink( 0.2 )
	end
end

function modifier_npc_megacreep_ranged_crystal:OnIntervalThink()
	if IsServer() then
		local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
							  self.crystal_position,
                              nil,
                              self.crystal_radius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
		for _,unit in pairs(units) do
			ApplyDamage({
				victim = unit,
				attacker = self:GetCaster(),
				damage = self.crystal_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility()
			})
		end

		if not self.crystal_caster or not self.crystal_caster:IsAlive() then
			print("acabou")
			ParticleManager:DestroyParticle( self.crystal_index, true )
			UTIL_Remove( self:GetParent() )
		end
	end
end
