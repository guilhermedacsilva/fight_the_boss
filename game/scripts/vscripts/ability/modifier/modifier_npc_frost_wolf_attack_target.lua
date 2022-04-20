modifier_npc_frost_wolf_attack_target = class({})

function modifier_npc_frost_wolf_attack_target:IsHidden()
	return false
end

function modifier_npc_frost_wolf_attack_target:IsPurgable()
	return true
end

function modifier_npc_frost_wolf_attack_target:IsDebuff()
	return true
end

function modifier_npc_frost_wolf_attack_target:GetEffectName()
	return "particles/econ/courier/courier_roshan_frost/courier_roshan_frost_ambient.vpcf"
end

function modifier_npc_frost_wolf_attack_target:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_npc_frost_wolf_attack_target:OnCreated( kv )
	self.frost_attack_slow = -self:GetAbility():GetSpecialValueFor( "slow" )
	self.frost_attack_duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self:SetDuration( self.frost_attack_duration, true )
end

function modifier_npc_frost_wolf_attack_target:OnRefresh( kv )
	self:SetDuration( self.frost_attack_duration, true )
end

function modifier_npc_frost_wolf_attack_target:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

function modifier_npc_frost_wolf_attack_target:GetModifierMoveSpeedBonus_Percentage(params)
	return self.frost_attack_slow
end


