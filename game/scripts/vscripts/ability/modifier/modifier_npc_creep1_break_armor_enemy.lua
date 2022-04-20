modifier_npc_creep1_break_armor_enemy = class({})

function modifier_npc_creep1_break_armor_enemy:IsHidden()
	return false
end

function modifier_npc_creep1_break_armor_enemy:IsPurgable()
	return true
end

function modifier_npc_creep1_break_armor_enemy:OnCreated( kv )
	self.creep1_armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self.creep1_duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self:SetDuration( self.creep1_duration, true )
end

function modifier_npc_creep1_break_armor_enemy:OnRefresh( kv )
	self:SetDuration( self.creep1_duration, true )
end

function modifier_npc_creep1_break_armor_enemy:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_npc_creep1_break_armor_enemy:GetModifierPhysicalArmorBonus(params)
	return self.creep1_armor * self:GetStackCount() * -1
end
