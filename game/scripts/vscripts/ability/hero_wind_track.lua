hero_wind_track = class ({})

LinkLuaModifier("modifier_hero_wind_track_caster", "ability/modifier_hero_wind_track_caster.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_hero_wind_track_target", "ability/modifier_hero_wind_track_target.lua", LUA_MODIFIER_MOTION_NONE )

function hero_wind_track:GetIntrinsicModifierName()
	return "modifier_hero_wind_track_caster"
end

function hero_wind_track:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		hTarget:AddNewModifier( self:GetCaster(), self, "modifier_hero_wind_track_target", nil )
	end
end
