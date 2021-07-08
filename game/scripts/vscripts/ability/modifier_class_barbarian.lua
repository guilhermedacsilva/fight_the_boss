modifier_class_barbarian = class({})

function modifier_class_barbarian:IsHidden()
	return true
end

function modifier_class_barbarian:DestroyOnExpire()
	return false
end

function modifier_class_barbarian:OnCreated( kv )
	self.modifier_class_barbarian_hp = 1
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end

function modifier_class_barbarian:IsPurgable()
	return false
end

function modifier_class_barbarian:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
	return funcs
end

function modifier_class_barbarian:GetModifierHealthBonus()
    return 200 * self:GetParent():GetLevel()
end

function modifier_class_barbarian:OnIntervalThink()
	if IsServer() then
		print(self:GetParent():GetLevel())
	end
end