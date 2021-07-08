modifier_hero_stunned = class({})

function modifier_hero_stunned:IsHidden()
	return false
end

function modifier_hero_stunned:IsPurgable()
	return true
end

function modifier_hero_stunned:IsDebuff()
	return true
end

function modifier_hero_stunned:IsStunDebuff()
	return true
end

function modifier_hero_stunned:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_hero_stunned:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_hero_stunned:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_hero_stunned:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

function modifier_hero_stunned:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end
