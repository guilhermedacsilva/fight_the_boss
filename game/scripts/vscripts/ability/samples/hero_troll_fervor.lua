hero_troll_fervor = class ({})

LinkLuaModifier("modifier_hero_troll_fervor", "ability/modifier_hero_troll_fervor.lua", LUA_MODIFIER_MOTION_NONE )

function hero_troll_fervor:OnSpellStart()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_hero_troll_fervor", {duration = self:GetSpecialValueFor( "duration" )} )
end
