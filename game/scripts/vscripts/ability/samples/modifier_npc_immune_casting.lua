modifier_npc_immune_casting = class({})

function modifier_npc_immune_casting:IsHidden()
	return true
end

function modifier_npc_immune_casting:IsPurgable()
	return false
end

function modifier_npc_immune_casting:IsStunDebuff()
	return true
end

function modifier_npc_immune_casting:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
	return state
end