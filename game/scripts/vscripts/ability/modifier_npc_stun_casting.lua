modifier_npc_stun_casting = class({})

function modifier_npc_stun_casting:IsHidden()
	return true
end

function modifier_npc_stun_casting:IsPurgable()
	return false
end

function modifier_npc_stun_casting:IsStunDebuff()
	return true
end

function modifier_npc_stun_casting:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end