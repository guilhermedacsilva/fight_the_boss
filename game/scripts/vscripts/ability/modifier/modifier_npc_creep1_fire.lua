modifier_npc_creep1_fire = class({})

function modifier_npc_creep1_fire:IsHidden()
	return true
end

function modifier_npc_creep1_fire:IsPurgable()
	return false
end

--function modifier_npc_creep1_fire:OnCreated( kv )
--end

function modifier_npc_creep1_fire:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_npc_creep1_fire:OnAttackLanded(params)
	local caster = self:GetCaster()

	if IsServer() and params.attacker == caster then
		local target = params.target
		local modifierName = "modifier_npc_creep1_fire_enemy"

		if target:HasModifier( modifierName ) then
			
			local current_stack = target:GetModifierStackCount( modifierName, self:GetAbility() )
			target:SetModifierStackCount( modifierName, self:GetAbility(), current_stack + 1 )
			target:AddNewModifier( caster, self:GetAbility(), modifierName, {})

		else

			target:AddNewModifier( caster, self:GetAbility(), modifierName, {})
			target:SetModifierStackCount( modifierName, self:GetAbility(), 1 )

		end

	end
end
