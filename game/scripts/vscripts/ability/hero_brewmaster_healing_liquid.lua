hero_brewmaster_healing_liquid = class ({})

LinkLuaModifier("modifier_hero_brewmaster_healing_liquid", "ability/modifier_hero_brewmaster_healing_liquid.lua", LUA_MODIFIER_MOTION_NONE )

function hero_brewmaster_healing_liquid:OnSpellStart()
	local radius = self:GetSpecialValueFor( "radius" )
	local buff_duration = self:GetSpecialValueFor( "duration" )
	local caster = self:GetCaster()

	local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
							  caster:GetOrigin(),
                              nil,
                              radius,
                              DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
	for _,unit in pairs(units) do
		unit:AddNewModifier( caster, self, "modifier_hero_brewmaster_healing_liquid", { duration = buff_duration } )
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_cast.vpcf", PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl(nFXIndex, 0, caster:GetOrigin() + Vector(0,0,100))
	ParticleManager:SetParticleControl(nFXIndex, 1, caster:GetOrigin() + Vector(0,0,300))
	ParticleManager:ReleaseParticleIndex( nFXIndex )
end
