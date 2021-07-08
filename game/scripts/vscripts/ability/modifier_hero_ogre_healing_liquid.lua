modifier_hero_ogre_healing_liquid = class({})

function modifier_hero_ogre_healing_liquid:IsHidden()
	return false
end

function modifier_hero_ogre_healing_liquid:IsPurgable()
	return true
end

function modifier_hero_ogre_healing_liquid:GetEffectName()
	return "particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_debuff.vpcf"
end

function modifier_hero_ogre_healing_liquid:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_hero_ogre_healing_liquid:OnCreated( kv )
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
	if self:GetParent():HasModifier("modifier_hero_ogre_inspiration") then
		self.healing_liquid_heal = self:GetAbility():GetSpecialValueFor( "heal" ) / duration * 2
	else
		self.healing_liquid_heal = self:GetAbility():GetSpecialValueFor( "heal" ) / duration
	end
end

function modifier_hero_ogre_healing_liquid:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

function modifier_hero_ogre_healing_liquid:GetModifierConstantHealthRegen()
    return self.healing_liquid_heal
end
