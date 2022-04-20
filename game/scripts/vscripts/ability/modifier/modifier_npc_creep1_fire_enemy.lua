modifier_npc_creep1_fire_enemy = class({})

function modifier_npc_creep1_fire_enemy:IsHidden()
	return false
end

function modifier_npc_creep1_fire_enemy:IsPurgable()
	return true
end

function modifier_npc_creep1_fire_enemy:IsDebuff()
	return true
end

function modifier_npc_creep1_fire_enemy:GetEffectName()
	return "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf"
end

function modifier_npc_creep1_fire_enemy:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_npc_creep1_fire_enemy:OnCreated( kv )
	if IsServer() then
		self.creep1_fire_damage = self:GetAbility():GetSpecialValueFor( "damage" )
		self.creep1_fire_duration = self:GetAbility():GetSpecialValueFor( "duration" )
		self:SetDuration( self.creep1_fire_duration, true )
		self:StartIntervalThink( 1 )
	end
end

function modifier_npc_creep1_fire_enemy:OnRefresh( kv )
	if IsServer() then
		self:SetDuration( self.creep1_fire_duration, true )
	end
end

function modifier_npc_creep1_fire_enemy:OnIntervalThink()
	if IsServer() then
		ApplyDamage({
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.creep1_fire_damage * self:GetStackCount(),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility()
		})
	end
end
