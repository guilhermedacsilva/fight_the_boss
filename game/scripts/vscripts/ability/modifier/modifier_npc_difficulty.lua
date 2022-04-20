modifier_npc_difficulty = class({})

function modifier_npc_difficulty:IsHidden()
	return true
end

function modifier_npc_difficulty:IsPurgable()
	return false
end

function modifier_npc_difficulty:OnCreated( kv )
	if IsServer() then
		local damage = self:GetCaster():GetBaseDamageMax()
		self.mod_npc_diff_damage = damage * GameRules.DIFFICULTY_DAMAGE
	end
end

function modifier_npc_difficulty:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
	return funcs
end

function modifier_npc_difficulty:GetModifierExtraHealthPercentage(params)
	return GameRules.DIFFICULTY_HEALTH
end

function modifier_npc_difficulty:GetModifierBaseAttack_BonusDamage(params)
	return self.mod_npc_diff_damage
end