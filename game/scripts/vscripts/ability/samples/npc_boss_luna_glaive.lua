npc_boss_luna_glaive = class ({})

LinkLuaModifier("modifier_npc_boss_luna_glaive", "ability/modifier_npc_boss_luna_glaive.lua", LUA_MODIFIER_MOTION_NONE )

function npc_boss_luna_glaive:GetIntrinsicModifierName()
	return "modifier_npc_boss_luna_glaive"
end

function npc_boss_luna_glaive:OnProjectileHit(hTarget, vLocation)
	local damage = 0
	if GameRules:IsDaytime() then
		damage = self:GetSpecialValueFor( "damage" )
	else
		damage = self:GetSpecialValueFor( "damage_night" )
	end
	ApplyDamage( {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self
	} )
end