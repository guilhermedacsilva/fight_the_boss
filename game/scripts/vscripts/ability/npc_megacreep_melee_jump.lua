npc_megacreep_melee_jump = class ({})

LinkLuaModifier( "modifier_npc_megacreep_melee_jump", "ability/modifier_npc_megacreep_melee_jump.lua", LUA_MODIFIER_MOTION_NONE )

function npc_megacreep_melee_jump:OnSpellStart()
	local radius = self:GetSpecialValueFor( "radius" )
	local cast_time = self:GetSpecialValueFor( "cast_time" )

	self:GetCaster():StartGestureWithPlaybackRate( ACT_DOTA_RELAX_START, 0.35 )
	AICore:CreateDangerCircle(self:GetCaster():GetOrigin(), radius, cast_time)
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_npc_immune_casting", { duration = cast_time } )

	CreateModifierThinker( self:GetCaster(), self, "modifier_npc_megacreep_melee_jump", {}, self:GetCaster():GetOrigin(), self:GetCaster():GetTeamNumber(), false )
end
