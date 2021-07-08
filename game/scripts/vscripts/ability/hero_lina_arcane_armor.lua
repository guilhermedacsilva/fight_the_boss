hero_lina_arcane_armor = class ({})

LinkLuaModifier("modifier_hero_lina_arcane_armor", "ability/modifier_hero_lina_arcane_armor.lua", LUA_MODIFIER_MOTION_NONE )

function hero_lina_arcane_armor:OnToggle()
	if self:GetToggleState() then
		local caster = self:GetCaster()
		caster:AddNewModifier( caster, self, "modifier_hero_lina_arcane_armor", nil )
		
		local p_name = "particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf"
		local particle = ParticleManager:CreateParticle(p_name, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(particle, 1, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 3, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
		self.particle = particle
		
	else
		self:GetCaster():RemoveModifierByName("modifier_hero_lina_arcane_armor")

		if self.particle then
			ParticleManager:DestroyParticle(self.particle, false)
		end
	end
end
