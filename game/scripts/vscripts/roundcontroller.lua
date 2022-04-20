if RoundController == nil then
	RoundController = class({})
end

function RoundController:Init()
	self.roundIndex = INITIAL_ROUND
	self.roundData = require("rounds")
	self.roundLastIndex = #self.roundData
	self.spawnerVector = Entities:FindByName(nil, "spawner_center"):GetCenter()
	self.event = ListenToGameEvent( "entity_killed", Dynamic_Wrap( RoundController, "OnEntityKilled" ), self )
	self.nextRoundNameTime = GameRules:GetGameTime() + 1
	self.nextRoundStartTime = 0
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, 1 )
end

function RoundController:OnThink()
	if GameRules:IsGamePaused() then
		return 1
	end
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then

		if self.nextRoundNameTime > 0 and self.nextRoundNameTime <= GameRules:GetGameTime() then
			self:ShowRoundName()
		elseif self.nextRoundStartTime > 0 and self.nextRoundStartTime <= GameRules:GetGameTime() then
			self:BeginRound()
		end

	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

function RoundController:ShowRoundName()
	self.nextRoundNameTime = 0
	self.nextRoundStartTime = GameRules:GetGameTime() + 3
	ShowMessageTop(self.roundData[self.roundIndex]["title"], 5)
end

function RoundController:BeginRound()
	self.nextRoundStartTime = 0
	self:HealAllPlayerUnits()
	self:CreateEnemies()
end

function RoundController:CreateEnemies()
	self.enemies = {}
	for _, enemyData in pairs(self.roundData[self.roundIndex]["units"]) do
		for qnt = 1, enemyData.qnt do
			local vectorRandom = Vector(RandomInt(-500,500),RandomInt(-500,500),0)
			local enemy = CreateUnitByName(enemyData.name, self.spawnerVector + vectorRandom, true, nil, nil, DOTA_TEAM_BADGUYS)
			table.insert(self.enemies, enemy)
		end
	end
end

function RoundController:OnEntityKilled(event)
	local killedUnit = EntIndexToHScript( event.entindex_killed )
	if not killedUnit then
		return
	end

	local removeIdx = nil
	for i, enemy in pairs( self.enemies ) do
		if enemy == killedUnit then
			removeIdx = i
			break
		end
	end

	if removeIdx ~= nil then
		table.remove(self.enemies, removeIdx)
	end

	if not self:Defeated() and #self.enemies == 0 then
		self:FinishRound()
	end
end

function RoundController:FinishRound()
	self:LevelUpPlayers()
	self:KillAllEnemies()

	self.roundIndex = self.roundIndex + 1
	if self.roundIndex > self.roundLastIndex then
		if TEST_HEROES then
			ShowMessageTop("Victory", 15)
		else
			GameRules:MakeTeamLose( DOTA_TEAM_BADGUYS )
		end
	else
		self.nextRoundNameTime = GameRules:GetGameTime() + 5
	end
end

function RoundController:KillAllEnemies()
	local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
				  Vector(0,0,0),
				  nil,
				  9999,
				  DOTA_UNIT_TARGET_TEAM_ENEMY,
				  DOTA_UNIT_TARGET_ALL,
				  DOTA_UNIT_TARGET_FLAG_NONE,
				  FIND_UNITS_EVERYWHERE,
				  false)
	for _, unit in pairs(units) do
		unit:ForceKill(false)
	end
end

function RoundController:LevelUpPlayers()
	for _, hero in pairs (HEROES) do
		if not hero:IsAlive() then
			hero:RespawnUnit()
		end
		--hero:ModifyGold(1000 + self.roundIndex * 150, true, 0)
		hero:AddExperience(100, 0, false, false)
	end
	self:HealAllPlayerUnits()
end

function RoundController:HealAllPlayerUnits()
	local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
				  Vector(0,0,0),
				  nil,
				  9999,
				  DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				  DOTA_UNIT_TARGET_ALL,
				  DOTA_UNIT_TARGET_FLAG_NONE,
				  FIND_UNITS_EVERYWHERE,
				  false)
	for _, unit in pairs(units) do
		unit:SetHealth( unit:GetMaxHealth() )
		unit:SetMana( unit:GetMaxMana() )
	end
end

function RoundController:Defeated()
	if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS or TEST_HEROES then
		return false
	end

	for _, hero in pairs (HEROES) do
		if hero and not hero:IsNull() and hero:IsAlive() then
			return false
		end
	end

	GameRules:MakeTeamLose( DOTA_TEAM_GOODGUYS )
	return true
end
