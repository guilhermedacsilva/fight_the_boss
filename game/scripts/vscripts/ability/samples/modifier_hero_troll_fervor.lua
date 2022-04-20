modifier_hero_troll_fervor = class({})

function modifier_hero_troll_fervor:IsHidden()
	return false
end

function modifier_hero_troll_fervor:IsPurgable()
	return false
end

function modifier_hero_troll_fervor:OnCreated( kv )
	self:UpdatePassiveBonus()
end

function modifier_hero_troll_fervor:OnRefresh( kv )
	self:UpdatePassiveBonus()
end

function modifier_hero_troll_fervor:UpdatePassiveBonus()
	self.fervor_atk_damage = self:GetAbility():GetSpecialValueFor( "atk_damage" )
	self.fervor_duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if self:GetCaster().bronze_skin_armor then
		self.bronze_skin_armor = self:GetCaster().bronze_skin_armor
		self.bronze_skin_magic_resistance = self:GetCaster().bronze_skin_magic_resistance
	else
		self.bronze_skin_armor = 0
		self.bronze_skin_magic_resistance = 0
	end

	if self:GetCaster().frenzy_atk_speed then
		self.frenzy_atk_speed = self:GetCaster().frenzy_atk_speed
		self.frenzy_mov_speed = self:GetCaster().frenzy_mov_speed
	else
		self.frenzy_atk_speed = 0
		self.frenzy_mov_speed = 0
	end
end

function modifier_hero_troll_fervor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_hero_troll_fervor:GetModifierBaseAttack_BonusDamage()
    return self.fervor_atk_damage
end

function modifier_hero_troll_fervor:OnAttack(params)
	if params.attacker == self:GetCaster() then
    	self:SetDuration( self.fervor_duration, true )
	end
end

function modifier_hero_troll_fervor:OnTakeDamage(params)
	if params.unit == self:GetCaster() then
    	self:SetDuration( self.fervor_duration, true )
	end
end

function modifier_hero_troll_fervor:GetModifierPhysicalArmorBonus()
	return self.bronze_skin_armor
end

function modifier_hero_troll_fervor:GetModifierMagicalResistanceBonus()
	return self.bronze_skin_magic_resistance
end

function modifier_hero_troll_fervor:GetModifierAttackSpeedBonus_Constant()
	return self.frenzy_atk_speed
end

function modifier_hero_troll_fervor:GetModifierMoveSpeedBonus_Constant()
	return self.frenzy_mov_speed
end