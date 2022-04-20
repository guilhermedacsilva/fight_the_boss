hero_omniknight_heal = class ({})

function hero_omniknight_heal:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		hTarget:Heal(self:GetSpecialValueFor( "heal" ), self:GetCaster())
		local pIdx = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
		ParticleManager:SetParticleControl(pIdx, 1, Vector(300,0,0))
		ParticleManager:ReleaseParticleIndex( pIdx )
	end
end
