modifier_hero_wind_hunters_eye = class({})

function modifier_hero_wind_hunters_eye:IsHidden()
	return false
end

function modifier_hero_wind_hunters_eye:IsPurgable()
	return true
end

function modifier_hero_wind_hunters_eye:GetEffectName()
	return "particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf"
end

function modifier_hero_wind_hunters_eye:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_hero_wind_hunters_eye:OnCreated( kv )
	self.wind_hunters_eye_atk_range = self:GetAbility():GetSpecialValueFor( "atk_range" )
	self.wind_hunters_eye_mov_speed = self:GetAbility():GetSpecialValueFor( "mov_speed" )
end

function modifier_hero_wind_hunters_eye:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
	return funcs
end

function modifier_hero_wind_hunters_eye:GetModifierAttackRangeBonus()
    return self.wind_hunters_eye_atk_range
end

function modifier_hero_wind_hunters_eye:GetModifierMoveSpeedBonus_Constant()
    return self.wind_hunters_eye_mov_speed
end
