hero_omniknight_divine_smite = class({})

LinkLuaModifier("modifier_hero_omniknight_divine_smite", "ability/modifier_hero_omniknight_divine_smite.lua", LUA_MODIFIER_MOTION_NONE )

function hero_omniknight_divine_smite:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		if ( not hTarget:TriggerSpellAbsorb( self ) ) then
			ApplyDamage( {
				victim = hTarget,
				attacker = self:GetCaster(),
				damage = self:GetSpecialValueFor( "damage" ),
				damage_type = DAMAGE_TYPE_PURE,
				ability = self
			} )
			hTarget:AddNewModifier( self:GetCaster(), self, "modifier_hero_omniknight_divine_smite", { duration = self:GetSpecialValueFor( "stun_duration" ) } )
		end

		local nFXIndex = ParticleManager:CreateParticle( "particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_ti6_immortal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget );
		ParticleManager:SetParticleControl(nFXIndex, 1, Vector(1,0,0))
		ParticleManager:ReleaseParticleIndex( nFXIndex );
	end
end
