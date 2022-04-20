hero_brewmaster_inspiration = class ({})

LinkLuaModifier("modifier_hero_brewmaster_inspiration", "ability/modifier_hero_brewmaster_inspiration.lua", LUA_MODIFIER_MOTION_NONE )

function hero_brewmaster_inspiration:OnSpellStart()
	local radius = self:GetSpecialValueFor( "radius" )
	local buff_duration = self:GetSpecialValueFor( "duration" )

	local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
                              self:GetCaster():GetOrigin(),
                              nil,
                              radius,
                              DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
	for _,unit in pairs(units) do
		unit:AddNewModifier( self:GetCaster(), self, "modifier_hero_brewmaster_inspiration", { duration = buff_duration } )
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/econ/events/ti9/shovel/shovel_baby_roshan_spawn_fireworks.vpcf",
		PATTACH_OVERHEAD_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
end
