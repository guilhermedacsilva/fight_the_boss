hero_ogre_dancing_fight = class ({})

LinkLuaModifier("modifier_hero_ogre_dancing_fight", "ability/modifier_hero_ogre_dancing_fight.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_hero_ogre_dancing_fight_crit", "ability/modifier_hero_ogre_dancing_fight_crit.lua", LUA_MODIFIER_MOTION_NONE )

function hero_ogre_dancing_fight:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		local duration = self:GetSpecialValueFor( "duration" )
		if hTarget:HasModifier("modifier_hero_ogre_inspiration") then
			duration = duration * 2
		end
		hTarget:AddNewModifier( self:GetCaster(), self, "modifier_hero_ogre_dancing_fight", {duration = duration} )
	end
end
