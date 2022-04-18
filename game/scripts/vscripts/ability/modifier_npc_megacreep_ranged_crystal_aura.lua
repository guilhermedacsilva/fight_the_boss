modifier_npc_megacreep_ranged_crystal_aura = class({})

function modifier_npc_megacreep_ranged_crystal_aura:IsHidden()
	return true
end

function modifier_npc_megacreep_ranged_crystal_aura:IsPurgable()
	return false
end

function modifier_npc_megacreep_ranged_crystal_aura:IsAura()
	return true
end

function modifier_npc_megacreep_ranged_crystal_aura:GetAuraRadius()
	return self.crystal_radius
end

function modifier_npc_megacreep_ranged_crystal_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_npc_megacreep_ranged_crystal_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_npc_megacreep_ranged_crystal_aura:GetModifierAura()
	return "modifier_npc_megacreep_ranged_crystal"
end

function modifier_npc_megacreep_ranged_crystal_aura:OnCreated( kv )
	if IsServer() then
		self.crystal_index = ParticleManager:CreateParticle( "particles/ring_crystal.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( self.crystal_index, 0, self:GetParent():GetOrigin() )
		self.crystal_radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self.crystal_caster = self:GetCaster()
		self:StartIntervalThink( 0.5 )
	end
end

function modifier_npc_megacreep_ranged_crystal_aura:OnIntervalThink()
	if IsServer() then
		if not self.crystal_caster or not self.crystal_caster:IsAlive() then
			ParticleManager:DestroyParticle( self.crystal_index, true )
			UTIL_Remove( self:GetParent() )
		end
	end
end
