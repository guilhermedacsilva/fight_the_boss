npc_creep1_fire = class ({})

LinkLuaModifier("modifier_npc_creep1_fire", "ability/modifier/modifier_npc_creep1_fire.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_npc_creep1_fire_enemy", "ability/modifier/modifier_npc_creep1_fire_enemy.lua", LUA_MODIFIER_MOTION_NONE )

function npc_creep1_fire:GetIntrinsicModifierName()
	return "modifier_npc_creep1_fire"
end