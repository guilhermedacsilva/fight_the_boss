modifier_hero_lina_arcane_armor = class({})

function modifier_hero_lina_arcane_armor:IsHidden()
	return false
end

function modifier_hero_lina_arcane_armor:IsPurgable()
	return false
end

function modifier_hero_lina_arcane_armor:OnCreated( kv )
	self.arcane_armor_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self.arcane_armor_mana_cost = self:GetAbility():GetSpecialValueFor( "mana_cost" ) / 2.0
	self.arcane_armor_caster = self:GetCaster()

	if IsServer() then
		self:StartIntervalThink( 0.5 )
	end
end

function modifier_hero_lina_arcane_armor:OnIntervalThink()
	if IsServer() then
		self.arcane_armor_caster:SetMana( self.arcane_armor_caster:GetMana() - self.arcane_armor_mana_cost )
		if (self.arcane_armor_caster:GetMana() < self.arcane_armor_mana_cost) then
			self:GetAbility():ToggleAbility()
		end
	end
end

function modifier_hero_lina_arcane_armor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_hero_lina_arcane_armor:GetModifierPhysicalArmorBonus()
	return self.arcane_armor_armor
end
