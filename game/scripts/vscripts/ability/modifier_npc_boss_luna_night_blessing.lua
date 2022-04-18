modifier_npc_boss_luna_night_blessing = class({})

function modifier_npc_boss_luna_night_blessing:IsHidden()
	return true
end

function modifier_npc_boss_luna_night_blessing:IsPurgable()
	return false
end

function modifier_npc_boss_luna_night_blessing:OnCreated( kv )
	self.night_blessing_active = false
	self.night_blessing_status = 0
	self.night_blessing_damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.night_blessing_radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.night_blessing_cast_time = self:GetAbility():GetSpecialValueFor( "cast_time" )
	self.night_blessing_wait_time = self:GetAbility():GetSpecialValueFor( "wait_time" )
end

function modifier_npc_boss_luna_night_blessing:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
	}
	return funcs
end

function modifier_npc_boss_luna_night_blessing:OnTakeDamage(params)
	if IsServer() then
		local caster = self:GetCaster()
		if not self.night_blessing_active and params.unit == caster and caster:GetHealthPercent() < 50 then
			self.night_blessing_active = true
			GameRules:SetTimeOfDay(0.76)
			
			self:StartIntervalThink( 1 )
			-- Start of day 0.26
			-- Start of night 0.76
		end
	end
end

function modifier_npc_boss_luna_night_blessing:OnIntervalThink()
	if IsServer() then
		local caster = self:GetCaster()
		if self.night_blessing_status == 0 then
			local pIdx = ParticleManager:CreateParticle("particles/danger_circle_fixed.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl( pIdx, 0, caster:GetOrigin() ) -- vec pos
			ParticleManager:SetParticleControl( pIdx, 1, Vector( 255, 255, 0 ) ) -- vec color
			ParticleManager:SetParticleControl( pIdx, 2, Vector( 120, 0, 0 ) ) -- alpha
			ParticleManager:SetParticleControl( pIdx, 3, Vector( self.night_blessing_radius, 0, 0 ) ) -- radius
			ParticleManager:SetParticleControl( pIdx, 4, Vector( self.night_blessing_cast_time, 0, 0 ) ) -- duration
			ParticleManager:ReleaseParticleIndex( pIdx )

			self.night_blessing_status = 1
			self:StartIntervalThink( self.night_blessing_cast_time-0.2 )

		else
			local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
							  caster:GetOrigin(),
                              nil,
                              self.night_blessing_radius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)

			for _,unit in pairs(units) do
				ApplyDamage({
					victim = unit,
					attacker = caster,
					damage = self.night_blessing_damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility()
				})
				unit:EmitSound("Hero_Luna.LucentBeam.Target")
				local position = unit:GetOrigin()
				local particle = ParticleManager:CreateParticle( "particles/econ/items/luna/luna_lucent_ti5_gold/luna_lucent_beam_moonfall_gold.vpcf", PATTACH_WORLDORIGIN, nil );
				ParticleManager:SetParticleControl(particle, 0, position)
				ParticleManager:SetParticleControl(particle, 1, position)
				ParticleManager:SetParticleControl(particle, 5, position)
				ParticleManager:SetParticleControl(particle, 6, position)
				ParticleManager:ReleaseParticleIndex( particle );
			end

			self.night_blessing_status = 0
			self:StartIntervalThink( self.night_blessing_wait_time )
		end
	end
end
