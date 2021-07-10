modifier_hero_ogre_dancing_fight_crit = class({})

function modifier_hero_ogre_dancing_fight_crit:IsHidden()
	return true
end

function modifier_hero_ogre_dancing_fight_crit:IsPurgable()
	return false
end

function modifier_hero_ogre_dancing_fight_crit:OnCreated( kv )
	self.dancing_fight_crit_damage = self:GetAbility():GetSpecialValueFor( "crit_damage" )
end

function modifier_hero_ogre_dancing_fight_crit:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_hero_ogre_dancing_fight_crit:GetModifierPreAttack_CriticalStrike()
	return self.dancing_fight_crit_damage
end

function modifier_hero_ogre_dancing_fight_crit:OnAttackLanded(params)
	local parent = self:GetParent()
	if IsServer() and params.attacker == parent then
		parent:RemoveModifierByName("modifier_hero_ogre_dancing_fight_crit")
	end
end
