modifier_hero_ogre_dancing_fight = class({})

function modifier_hero_ogre_dancing_fight:IsHidden()
	return false
end

function modifier_hero_ogre_dancing_fight:IsPurgable()
	return true
end

function modifier_hero_ogre_dancing_fight:GetEffectName()
	return "particles/dancing_fight.vpcf"
end

function modifier_hero_ogre_dancing_fight:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_hero_ogre_dancing_fight:OnCreated( kv )
	self.dancing_fight_crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.dancing_fight_evasion = self:GetAbility():GetSpecialValueFor( "evasion" )
end

function modifier_hero_ogre_dancing_fight:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
	return funcs
end

function modifier_hero_ogre_dancing_fight:OnAttackStart(params)
	local parent = self:GetParent()
	if IsServer() and params.attacker == parent and RandomInt(1,100) <= self.dancing_fight_crit_chance then
		parent:AddNewModifier( parent, self:GetAbility(), "modifier_hero_ogre_dancing_fight_crit", {duration = 2})
	end
end

function modifier_hero_ogre_dancing_fight:GetModifierEvasion_Constant()
	return self.dancing_fight_evasion
end
