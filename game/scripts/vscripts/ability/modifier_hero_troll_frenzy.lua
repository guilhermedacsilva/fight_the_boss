modifier_hero_troll_frenzy = class({})

function modifier_hero_troll_frenzy:IsHidden()
	return true
end

function modifier_hero_troll_frenzy:IsPurgable()
	return false
end

function modifier_hero_troll_frenzy:OnCreated( kv )
	self.frenzy_atk_speed = self:GetAbility():GetSpecialValueFor( "atk_speed" )
	self.frenzy_mov_speed = self:GetAbility():GetSpecialValueFor( "mov_speed" )
	self:GetCaster().frenzy_atk_speed = self:GetAbility():GetSpecialValueFor( "atk_speed" )
	self:GetCaster().frenzy_mov_speed = self:GetAbility():GetSpecialValueFor( "mov_speed" )
end

function modifier_hero_troll_frenzy:OnRefresh( kv )
	self.frenzy_atk_speed = self:GetAbility():GetSpecialValueFor( "atk_speed" )
	self.frenzy_mov_speed = self:GetAbility():GetSpecialValueFor( "mov_speed" )
	self:GetCaster().frenzy_atk_speed = self:GetAbility():GetSpecialValueFor( "atk_speed" )
	self:GetCaster().frenzy_mov_speed = self:GetAbility():GetSpecialValueFor( "mov_speed" )
end

function modifier_hero_troll_frenzy:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_hero_troll_frenzy:GetModifierAttackSpeedBonus_Constant()
	return self.frenzy_atk_speed
end

function modifier_hero_troll_frenzy:GetModifierMoveSpeedBonus_Constant()
	return self.frenzy_mov_speed
end
