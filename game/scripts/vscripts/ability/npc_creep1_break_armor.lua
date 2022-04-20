npc_creep1_break_armor = class ({})

LinkLuaModifier("modifier_npc_creep1_break_armor", "ability/modifier/modifier_npc_creep1_break_armor.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_npc_creep1_break_armor_enemy", "ability/modifier/modifier_npc_creep1_break_armor_enemy.lua", LUA_MODIFIER_MOTION_NONE )

function npc_creep1_break_armor:GetIntrinsicModifierName()
	return "modifier_npc_creep1_break_armor"
end