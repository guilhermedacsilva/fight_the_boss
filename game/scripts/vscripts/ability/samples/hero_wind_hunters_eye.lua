hero_wind_hunters_eye = class ({})

LinkLuaModifier("modifier_hero_wind_hunters_eye", "ability/modifier_hero_wind_hunters_eye.lua", LUA_MODIFIER_MOTION_NONE )

function hero_wind_hunters_eye:OnSpellStart()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_hero_wind_hunters_eye", {duration = self:GetSpecialValueFor( "duration" )} )
end
