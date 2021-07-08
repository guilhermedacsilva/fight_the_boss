modifier_hero_wind_track_caster = class({})

function modifier_hero_wind_track_caster:IsHidden()
	return true
end

function modifier_hero_wind_track_caster:IsPurgable()
	return false
end

function modifier_hero_wind_track_caster:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_hero_wind_track_caster:OnAttackLanded(params)
	local target = params.target
	local caster = self:GetCaster()
	if IsServer() and params.attacker == caster and target:HasModifier("modifier_hero_wind_track_target") then
		ApplyDamage( {
			victim = target,
			attacker = caster,
			damage = self:GetAbility():GetSpecialValueFor( "atk_damage" ),
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self:GetAbility()
		} )
	end
end
