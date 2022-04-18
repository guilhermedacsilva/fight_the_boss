npc_megacreep_ranged_crystal = class ({})

LinkLuaModifier( "modifier_npc_megacreep_ranged_crystal", "ability/modifier_npc_megacreep_ranged_crystal.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_npc_megacreep_ranged_crystal_aura", "ability/modifier_npc_megacreep_ranged_crystal_aura.lua", LUA_MODIFIER_MOTION_NONE )

function npc_megacreep_ranged_crystal:OnSpellStart()
	local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
                              Vector(0,0,0),
                              nil,
                              FIND_UNITS_EVERYWHERE,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
	for _, enemy in pairs(units) do
		CreateModifierThinker( self:GetCaster(), self, "modifier_npc_megacreep_ranged_crystal_aura", {}, enemy:GetOrigin(), self:GetCaster():GetTeamNumber(), false )
	end
end
