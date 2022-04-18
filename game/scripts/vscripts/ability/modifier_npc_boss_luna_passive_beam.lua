modifier_npc_boss_luna_passive_beam = class({})

function modifier_npc_boss_luna_passive_beam:IsHidden()
	return true
end

function modifier_npc_boss_luna_passive_beam:IsPurgable()
	return false
end

function modifier_npc_boss_luna_passive_beam:OnCreated( kv )
	if IsServer() then
		self.passive_beam_do_nothing_time = self:GetAbility():GetSpecialValueFor( "do_nothing_time" )
		self.passive_beam_follow_time = self:GetAbility():GetSpecialValueFor( "follow_time" )
		self.passive_beam_pre_beam_time = self:GetAbility():GetSpecialValueFor( "pre_beam_time" )
		self.passive_beam_damage = self:GetAbility():GetSpecialValueFor( "beam_damage" )
		self.passive_beam_damage_night = self:GetAbility():GetSpecialValueFor( "beam_damage_night" )
		self.passive_beam_radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self.passive_beam_caster = self:GetCaster()
		self.passive_beam_status = 0

		self:StartIntervalThink( self.passive_beam_do_nothing_time )
	end
end

function modifier_npc_boss_luna_passive_beam:OnIntervalThink()
	if IsServer() then
		if not self.passive_beam_caster or not self.passive_beam_caster:IsAlive() then
			UTIL_Remove( self:GetParent() )
			return
		end

		if self.passive_beam_status == 0 then
			-- create and follow
			local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
                              Vector(0,0,0),
                              nil,
                              FIND_UNITS_EVERYWHERE,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)

			if #units > 0 then
				self.passive_beam_target = units[RandomInt(1, #units)]
				AICore:CreateDangerCircleFollow(self.passive_beam_target, self.passive_beam_radius, self.passive_beam_follow_time)
				self.passive_beam_status = 1
				self:StartIntervalThink( self.passive_beam_follow_time-0.05 )
			end

		elseif self.passive_beam_status == 1 then
			if self.passive_beam_target == nil or not self.passive_beam_target:IsAlive() then
				self.passive_beam_status = 0
				self:StartIntervalThink( self.passive_beam_do_nothing_time )

			else
				self.passive_beam_position = self.passive_beam_target:GetOrigin()
				AICore:CreateDangerCircleInstant(self.passive_beam_position, self.passive_beam_radius, self.passive_beam_pre_beam_time)
				self.passive_beam_status = 2
				self:StartIntervalThink( self.passive_beam_pre_beam_time )
			end

		else
			local particle = ParticleManager:CreateParticle( "particles/econ/items/luna/luna_lucent_ti5/luna_lucent_beam_moonfall.vpcf", PATTACH_WORLDORIGIN, nil );
			ParticleManager:SetParticleControl(particle, 0, self.passive_beam_position)
			ParticleManager:SetParticleControl(particle, 1, self.passive_beam_position)
			ParticleManager:SetParticleControl(particle, 5, self.passive_beam_position)
			ParticleManager:SetParticleControl(particle, 6, self.passive_beam_position)
			ParticleManager:ReleaseParticleIndex( particle );


			local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
							  self.passive_beam_position,
                              nil,
                              self.passive_beam_radius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
			
			local damage = 0
			if GameRules:IsDaytime() then
				damage = self.passive_beam_damage
			else
				damage = self.passive_beam_damage_night
			end
			for _,unit in pairs(units) do
				ApplyDamage({
					victim = unit,
					attacker = self.passive_beam_caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility()
				})
				unit:EmitSound("Hero_Luna.LucentBeam.Target")
			end

			self.passive_beam_status = 0
			self:StartIntervalThink( self.passive_beam_do_nothing_time )
		end
	end
end
