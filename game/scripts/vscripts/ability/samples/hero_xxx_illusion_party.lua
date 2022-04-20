hero_xxx_illusion_party = class ({})

function hero_xxx_illusion_party:OnSpellStart()
	local qnt = self:GetSpecialValueFor( "qnt" )
	local duration = self:GetSpecialValueFor( "duration" )
	local outgoing_damage = self:GetSpecialValueFor( "outgoing_damage" )
	local incoming_damage = self:GetSpecialValueFor( "incoming_damage" )
	local caster = self:GetCaster()
	
	CreateIllusions(
		caster, -- owner
		caster, -- unit
		{ -- modifiers
			duration = duration,
			outgoing_damage = outgoing_damage,
			incoming_damage = incoming_damage
		},
		qnt, -- qnt
		100, -- padding
		false, -- scramble
		true -- find clear space
	)
end
