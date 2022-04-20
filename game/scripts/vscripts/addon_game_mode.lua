require('internal/util')
require('settings')
require('roundcontroller')
require('ai/aicore')

if GameMode == nil then
	GameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	
	PrecacheItemByNameAsync( "item_tombstone", function(...) end )
end

function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitRules()
end

function GameMode:InitRules()
	GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
	GameRules:SetUseUniversalShopMode( UNIVERSAL_SHOP_MODE )
	GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
	GameRules:SetStrategyTime( 0 )
	GameRules:SetHeroSelectionTime( HERO_SELECTION_TIME )
	GameRules:SetPreGameTime( PRE_GAME_TIME)
	GameRules:SetPostGameTime( POST_GAME_TIME )
	GameRules:SetUseCustomHeroXPValues ( USE_CUSTOM_XP_VALUES )
	GameRules:SetFirstBloodActive( ENABLE_FIRST_BLOOD )
	GameRules:SetHideKillMessageHeaders( HIDE_KILL_BANNERS )
	GameRules:SetCustomGameEndDelay( GAME_END_DELAY )
	GameRules:SetCustomVictoryMessageDuration( VICTORY_MESSAGE_DURATION )
	GameRules:SetStartingGold( STARTING_GOLD )
	GameRules:SetCustomGameSetupAutoLaunchDelay( 0 )
	GameRules:LockCustomGameSetupTeamAssignment( true )
	GameRules:EnableCustomGameSetupAutoLaunch( true )
	GameRules:SetSafeToLeave(true)

	ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, '_OnConnectFull'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, '_OnGameRulesStateChange'), self)

	local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '^0+','')
	math.randomseed(tonumber(timeTxt))

	-- This is multiteam configuration stuff
	--[[
	if USE_AUTOMATIC_PLAYERS_PER_TEAM then
		local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
		local count = 0
		for team,number in pairs(TEAM_COLORS) do
			if count >= MAX_NUMBER_OF_TEAMS then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, num)
			end
			count = count + 1
		end
	else
		local count = 0
		for team,number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
			if count >= MAX_NUMBER_OF_TEAMS then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, number)
			end
			count = count + 1
		end
	end
	]]--
end

mode = nil

function GameMode:_OnConnectFull(keys)
	if mode == nil then
		mode = GameRules:GetGameModeEntity()
		mode:SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
		mode:SetCameraDistanceOverride( CAMERA_DISTANCE_OVERRIDE )
		mode:SetBuybackEnabled( BUYBACK_ENABLED )
		mode:SetTopBarTeamValuesOverride ( USE_CUSTOM_TOP_BAR_VALUES )
		mode:SetTopBarTeamValuesVisible( TOP_BAR_VISIBLE )
		mode:SetUseCustomHeroLevels ( USE_CUSTOM_HERO_LEVELS )
		mode:SetCustomHeroMaxLevel ( MAX_LEVEL )
		mode:SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )
		mode:SetBotThinkingEnabled( USE_STANDARD_DOTA_BOT_THINKING )
		mode:SetTowerBackdoorProtectionEnabled( ENABLE_TOWER_BACKDOOR_PROTECTION )
		mode:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
		mode:SetGoldSoundDisabled( DISABLE_GOLD_SOUNDS )
		mode:SetRemoveIllusionsOnDeath( REMOVE_ILLUSIONS_ON_DEATH )
		mode:SetAlwaysShowPlayerInventory( SHOW_ONLY_PLAYER_INVENTORY )
		mode:SetAnnouncerDisabled( DISABLE_ANNOUNCER )
		if FORCE_PICKED_HERO ~= nil then
			mode:SetCustomGameForceHero( FORCE_PICKED_HERO )
		end
		mode:SetLoseGoldOnDeath( LOSE_GOLD_ON_DEATH )
		mode:SetMaximumAttackSpeed( MAXIMUM_ATTACK_SPEED )
		mode:SetMinimumAttackSpeed( MINIMUM_ATTACK_SPEED )
		mode:SetStashPurchasingDisabled ( DISABLE_STASH_PURCHASING )
		mode:SetDaynightCycleDisabled( DISABLE_DAY_NIGHT_CYCLE )
		mode:SetKillingSpreeAnnouncerDisabled( DISABLE_KILLING_SPREE_ANNOUNCER )
		mode:SetStickyItemDisabled( DISABLE_STICKY_ITEM )
		for i=0,8 do
			mode:SetCustomAttributeDerivedStatValue(i, 0)
		end
		mode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP , 50)
		mode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA  , 50)
	end
end

function GameMode:_OnGameRulesStateChange(keys)
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
	  GameMode:InitGame()
	end
end

function GameMode:InitGame()
	if TEST_HEROES then
		require("test_heroes")

		HEROES_QNT = DEBUG_QNT_HEROES

		--LinkLuaModifier( "modifier_npc_stun_casting", "ability/modifier_npc_stun_casting.lua", LUA_MODIFIER_MOTION_NONE )
		--LinkLuaModifier( "modifier_hero_stunned", "ability/modifier_hero_stunned.lua", LUA_MODIFIER_MOTION_NONE )
		--GameRules:SetTimeOfDay(0.26) -- day: 0.26 | night: 0.76
		--local spawnerVector = Entities:FindByName(nil, "spawner_center"):GetAbsOrigin()
		--local boss = CreateUnitByName("npc_boss_luna", spawnerVector, true, nil, nil, DOTA_TEAM_BADGUYS)
		
	else
		for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
			if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS and PlayerResource:HasSelectedHero( nPlayerID ) then
				local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
				table.insert(HEROES, hero)
			end
		end

		HEROES_QNT = #HEROES
	end
	
	GameRules.DIFFICULTY_HEALTH = 100 * (HEROES_QNT - 1)
	GameRules.DIFFICULTY_DAMAGE = 0.35 * (HEROES_QNT - 1)
	RoundController:Init()
end
