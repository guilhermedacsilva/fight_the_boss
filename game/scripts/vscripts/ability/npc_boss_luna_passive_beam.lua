npc_boss_luna_passive_beam = class ({})

LinkLuaModifier("modifier_npc_boss_luna_passive_beam", "ability/modifier_npc_boss_luna_passive_beam.lua", LUA_MODIFIER_MOTION_NONE )

function npc_boss_luna_passive_beam:GetIntrinsicModifierName()
	return "modifier_npc_boss_luna_passive_beam"
end
