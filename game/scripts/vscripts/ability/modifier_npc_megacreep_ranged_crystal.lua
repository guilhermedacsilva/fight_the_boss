modifier_npc_megacreep_ranged_crystal = class({})

function modifier_npc_megacreep_ranged_crystal:IsHidden()
	return false
end

function modifier_npc_megacreep_ranged_crystal:IsPurgable()
	return false
end

function modifier_npc_megacreep_ranged_crystal:OnCreated( kv )
	if IsServer() then
		self.crystal_damage = self:GetAbility():GetSpecialValueFor( "damage" )
		self:StartIntervalThink( 0.2 )
	end
end

function modifier_npc_megacreep_ranged_crystal:OnIntervalThink()
	if IsServer() then
		ApplyDamage({
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.crystal_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility()
		})
	end
end
