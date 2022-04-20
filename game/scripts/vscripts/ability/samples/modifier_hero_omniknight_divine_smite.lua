modifier_hero_omniknight_divine_smite = class({})

function modifier_hero_omniknight_divine_smite:IsHidden()
	return false
end

function modifier_hero_omniknight_divine_smite:IsPurgable()
	return true
end

function modifier_hero_omniknight_divine_smite:IsDebuff()
	return true
end

function modifier_hero_omniknight_divine_smite:IsStunDebuff()
	return true
end

function modifier_hero_omniknight_divine_smite:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_hero_omniknight_divine_smite:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_hero_omniknight_divine_smite:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true
	}
	return state
end

function modifier_hero_omniknight_divine_smite:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
	return funcs
end

function modifier_hero_omniknight_divine_smite:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end