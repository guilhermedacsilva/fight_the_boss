modifier_hero_omniknight_retribution = class({})

function modifier_hero_omniknight_retribution:IsHidden()
	return true
end

function modifier_hero_omniknight_retribution:IsPurgable()
	return false
end

function modifier_hero_omniknight_retribution:OnCreated( kv )
	self.retribution_return_damage = self:GetAbility():GetSpecialValueFor( "return_damage" )
end

function modifier_hero_omniknight_retribution:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
	}
	return funcs
end

function modifier_hero_omniknight_retribution:OnTakeDamage(params)
	local caster = self:GetCaster()
	if IsServer() and params.unit == caster then
		local return_damage = params.damage / 100.0 * self.retribution_return_damage
		if caster:GetHealth() > 0 then
			caster:SetHealth(caster:GetHealth() + return_damage)
		end
		ApplyDamage( {
			victim = params.attacker,
			attacker = caster,
			damage = return_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility()
		} )
	end
end
