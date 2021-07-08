modifier_hero_troll_bronze_skin = class({})

function modifier_hero_troll_bronze_skin:IsHidden()
	return true
end

function modifier_hero_troll_bronze_skin:IsPurgable()
	return false
end

function modifier_hero_troll_bronze_skin:OnCreated( kv )
	self.bronze_skin_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self.bronze_skin_magic_resistance = self:GetAbility():GetSpecialValueFor( "magic_resistance" )
	self:GetCaster().bronze_skin_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self:GetCaster().bronze_skin_magic_resistance = self:GetAbility():GetSpecialValueFor( "magic_resistance" )
end

function modifier_hero_troll_bronze_skin:OnRefresh( kv )
	self.bronze_skin_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self.bronze_skin_magic_resistance = self:GetAbility():GetSpecialValueFor( "magic_resistance" )
	self:GetCaster().bronze_skin_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self:GetCaster().bronze_skin_magic_resistance = self:GetAbility():GetSpecialValueFor( "magic_resistance" )
end

function modifier_hero_troll_bronze_skin:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
	return funcs
end

function modifier_hero_troll_bronze_skin:GetModifierPhysicalArmorBonus()
	return self.bronze_skin_armor
end

function modifier_hero_troll_bronze_skin:GetModifierMagicalResistanceBonus()
	return self.bronze_skin_magic_resistance
end
