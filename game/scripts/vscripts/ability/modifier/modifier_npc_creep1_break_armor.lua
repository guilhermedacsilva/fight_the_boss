modifier_npc_creep1_break_armor = class({})

function modifier_npc_creep1_break_armor:IsHidden()
	return true
end

function modifier_npc_creep1_break_armor:IsPurgable()
	return false
end

--function modifier_npc_creep1_break_armor:OnCreated( kv )
--end

function modifier_npc_creep1_break_armor:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_npc_creep1_break_armor:OnAttackLanded(params)
	local caster = self:GetCaster()

	if IsServer() and params.attacker == caster then
		local target = params.target
		local modifierName = "modifier_npc_creep1_break_armor_enemy"

		if target:HasModifier( modifierName ) then
			
			local current_stack = target:GetModifierStackCount( modifierName, self:GetAbility() )
			target:SetModifierStackCount( modifierName, self:GetAbility(), current_stack + 1 )
			target:AddNewModifier( caster, self:GetAbility(), modifierName, {duration = self.creep1_duration})

		else

			target:AddNewModifier( caster, self:GetAbility(), modifierName, {duration = self.creep1_duration})
			target:SetModifierStackCount( modifierName, self:GetAbility(), 1 )

		end

	end
end
