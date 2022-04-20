class_barbarian = class ({})

LinkLuaModifier("modifier_class_barbarian", "ability/modifier_class_barbarian.lua", LUA_MODIFIER_MOTION_NONE )

function class_barbarian:GetIntrinsicModifierName()
	return "modifier_class_barbarian"
end
