hero_lina_mana_beam = class({})

function hero_lina_mana_beam:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		if ( not hTarget:TriggerSpellAbsorb( self ) ) then
			EmitSoundOn( "Ability.LagunaBladeImpact", hTarget )

			local damage = hTarget:GetMaxHealth() / 100 * self:GetSpecialValueFor( "percent" ) + self:GetSpecialValueFor( "damage" )

			ApplyDamage( {
				victim = hTarget,
				attacker = self:GetCaster(),
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self
			} )
		end

		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
		ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
		ParticleManager:ReleaseParticleIndex( nFXIndex );

		EmitSoundOn( "Ability.LagunaBladeImpact", self:GetCaster() )
	end
end
