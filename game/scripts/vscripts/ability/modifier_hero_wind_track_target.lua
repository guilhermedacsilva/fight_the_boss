modifier_hero_wind_track_target = class({})

function modifier_hero_wind_track_target:IsHidden()
	return false
end

function modifier_hero_wind_track_target:IsPurgable()
	return false
end

function modifier_hero_wind_track_target:IsDebuff()
	return true
end
