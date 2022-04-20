modifier_npc_frost_wolf_attack = class({})

function modifier_npc_frost_wolf_attack:IsHidden()
	return true
end

function modifier_npc_frost_wolf_attack:IsPurgable()
	return false
end

--function modifier_npc_frost_wolf_attack:OnCreated( kv )
--end

function modifier_npc_frost_wolf_attack:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_npc_frost_wolf_attack:OnAttackLanded(params)
	local caster = self:GetCaster()

	if IsServer() and params.attacker == caster then
		local target = params.target
		local modifierName = "modifier_npc_frost_wolf_attack_target"
		target:AddNewModifier( caster, self:GetAbility(), modifierName, {duration = 1})
	end
end
