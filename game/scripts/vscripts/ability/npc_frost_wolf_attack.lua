npc_frost_wolf_attack = class ({})

LinkLuaModifier("modifier_npc_frost_wolf_attack", "ability/modifier/modifier_npc_frost_wolf_attack.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_npc_frost_wolf_attack_target", "ability/modifier/modifier_npc_frost_wolf_attack_target.lua", LUA_MODIFIER_MOTION_NONE )

function npc_frost_wolf_attack:GetIntrinsicModifierName()
	return "modifier_npc_frost_wolf_attack"
end