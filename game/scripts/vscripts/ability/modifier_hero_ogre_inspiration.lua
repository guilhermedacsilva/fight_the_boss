modifier_hero_ogre_inspiration = class({})

function modifier_hero_ogre_inspiration:IsHidden()
	return false
end

function modifier_hero_ogre_inspiration:IsPurgable()
	return true
end

function modifier_hero_ogre_inspiration:GetEffectName()
	return "particles/econ/courier/courier_hwytty/courier_hwytty_ambient.vpcf"
end

function modifier_hero_ogre_inspiration:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_hero_ogre_inspiration:OnCreated( kv )
	self.inspiration_atk_speed = self:GetAbility():GetSpecialValueFor( "atk_speed" )
end

function modifier_hero_ogre_inspiration:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_hero_ogre_inspiration:GetModifierAttackSpeedBonus_Constant()
    return self.inspiration_atk_speed
end
