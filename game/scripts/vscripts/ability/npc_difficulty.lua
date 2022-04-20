npc_difficulty = class ({})

LinkLuaModifier("modifier_npc_difficulty", "ability/modifier/modifier_npc_difficulty.lua", LUA_MODIFIER_MOTION_NONE )

function npc_difficulty:GetIntrinsicModifierName()
	return "modifier_npc_difficulty"
end