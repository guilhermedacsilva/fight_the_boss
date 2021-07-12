modifier_hero_wind_explorer_path = class({})

function modifier_hero_wind_explorer_path:IsHidden()
	return true
end

function modifier_hero_wind_explorer_path:IsPurgable()
	return false
end

function modifier_hero_wind_explorer_path:OnCreated( kv )
	self.wind_explorer_path_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self.wind_explorer_path_mov_speed = self:GetAbility():GetSpecialValueFor( "mov_speed" )
end

function modifier_hero_wind_explorer_path:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_hero_wind_explorer_path:GetModifierPhysicalArmorBonus()
    return self.wind_explorer_path_armor
end

function modifier_hero_wind_explorer_path:GetModifierMoveSpeedBonus_Constant()
    return self.wind_explorer_path_mov_speed
end
