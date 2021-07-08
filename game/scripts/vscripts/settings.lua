TEST_HEROES = true

-- MY GLOBALS
HEROES = {}
GOLD_TABLE = {}
GOLD_TABLE[1] = 100
for i=2,20 do
  GOLD_TABLE[i] = GOLD_TABLE[i-1] * 2
end

INITIAL_ROUND = 2
STARTING_GOLD = 0

if TEST_HEROES then
    DEBUG_QNT_HEROES = 3
    FORCE_PICKED_HERO = "npc_dota_hero_troll_warlord"
    STARTING_GOLD = 99999
end

ENABLE_HERO_RESPAWN = false              -- Should the heroes automatically respawn on a timer or stay dead until manually respawned
UNIVERSAL_SHOP_MODE = true             -- Should the main shop contain Secret Shop items as well as regular items
ALLOW_SAME_HERO_SELECTION = false        -- Should we let people select the same hero as each other


-- USED FILTER ITEMS
--[[
SHOP_CLASS_ITEM = {
    weapons = {
        "item_claws_datadriven",
        "item_claymore_datadriven",
        "item_axe_datadriven",
        "item_javelin_datadriven",
        "item_demon_edge_datadriven",
        "item_reaver_datadriven",
        "item_dragon_lance_datadriven"
    },
    armors = {
        "item_wood_shield_datadriven",
        "item_chainmail_datadriven",
        "item_iron_shield_datadriven",
        "item_iron_helm_datadriven",
        "item_platemail_datadriven",
        "item_buckler_datadriven"
    }
}
SHOP_ITEM_CLASS = {}
for c,itemList in pairs(SHOP_CLASS_ITEM) do
    for _,item in pairs(itemList) do
        SHOP_ITEM_CLASS[item] = c
    end
end
]]--


HERO_SELECTION_TIME = 30.0              -- How long should we let people select their hero?
PRE_GAME_TIME = 1.0                    -- How long after people select their heroes should the horn blow and the game start?
POST_GAME_TIME = 60.0                   -- How long should we let people look at the scoreboard before closing the server automatically?
--TREE_REGROW_TIME = 999.0                 -- How long should it take individual trees to respawn after being cut down/destroyed?
--GOLD_PER_TICK = 0                     -- How much gold should players get per tick?
--GOLD_TICK_TIME = 10                      -- How long should we wait in seconds between gold ticks?

RECOMMENDED_BUILDS_DISABLED = true     -- Should we disable the recommened builds for heroes
CAMERA_DISTANCE_OVERRIDE = -1           -- How far out should we allow the camera to go?  Use -1 for the default (1134) while still allowing for panorama camera distance changes

--MINIMAP_ICON_SIZE = 1                   -- What icon size should we use for our heroes?
--MINIMAP_CREEP_ICON_SIZE = 1             -- What icon size should we use for creeps?
--MINIMAP_RUNE_ICON_SIZE = 1              -- What icon size should we use for runes?

--RUNE_SPAWN_TIME = 120                   -- How long in seconds should we wait between rune spawns?
--CUSTOM_BUYBACK_COST_ENABLED = true      -- Should we use a custom buyback cost setting?
--CUSTOM_BUYBACK_COOLDOWN_ENABLED = true  -- Should we use a custom buyback time?
BUYBACK_ENABLED = false                 -- Should we allow people to buyback when they die?

DISABLE_FOG_OF_WAR_ENTIRELY = true     -- Should we disable fog of war entirely for both teams?
--USE_UNSEEN_FOG_OF_WAR = true           -- Should we make unseen and fogged areas of the map completely black until uncovered by each team?
                                            -- Note: DISABLE_FOG_OF_WAR_ENTIRELY must be false for USE_UNSEEN_FOG_OF_WAR to work
USE_STANDARD_DOTA_BOT_THINKING = false  -- Should we have bots act like they would in Dota? (This requires 3 lanes, normal items, etc)
--USE_STANDARD_HERO_GOLD_BOUNTY = false    -- Should we give gold for hero kills the same as in Dota, or allow those values to be changed?

USE_CUSTOM_TOP_BAR_VALUES = true        -- Should we do customized top bar values or use the default kill count per team?
TOP_BAR_VISIBLE = false                  -- Should we display the top bar score/count at all?
SHOW_KILLS_ON_TOPBAR = false             -- Should we display kills only on the top bar? (No denies, suicides, kills by neutrals)  Requires USE_CUSTOM_TOP_BAR_VALUES

ENABLE_TOWER_BACKDOOR_PROTECTION = false-- Should we enable backdoor protection for our towers?
REMOVE_ILLUSIONS_ON_DEATH = false       -- Should we remove all illusions if the main hero dies?
DISABLE_GOLD_SOUNDS = false             -- Should we disable the gold sound when players get gold?

--END_GAME_ON_KILLS = false                -- Should the game end after a certain number of kills?
--KILLS_TO_END_GAME_FOR_TEAM = 50         -- How many kills for a team should signify an end of game?

USE_CUSTOM_HERO_LEVELS = true           -- Should we allow heroes to have custom levels?
MAX_LEVEL = 50                          -- What level should we let heroes get to?
USE_CUSTOM_XP_VALUES = true             -- Should we use custom XP values to level up heroes, or the default Dota numbers?

-- Fill this table up with the required XP per level if you want to change it
XP_PER_LEVEL_TABLE = {}
for i=1,MAX_LEVEL do
  XP_PER_LEVEL_TABLE[i] = (i-1) * 100
end

ENABLE_FIRST_BLOOD = false               -- Should we enable first blood for the first kill in this game?
HIDE_KILL_BANNERS = false               -- Should we hide the kill banners that show when a player is killed?
LOSE_GOLD_ON_DEATH = false               -- Should we have players lose the normal amount of dota gold on death?
SHOW_ONLY_PLAYER_INVENTORY = false      -- Should we only allow players to see their own inventory even when selecting other units?
DISABLE_STASH_PURCHASING = true        -- Should we prevent players from being able to buy items into their stash when not at a shop?
DISABLE_ANNOUNCER = true               -- Should we disable the announcer from working in the game?

--FIXED_RESPAWN_TIME = -1                 -- What time should we use for a fixed respawn timer?  Use -1 to keep the default dota behavior.
--FOUNTAIN_CONSTANT_MANA_REGEN = -1       -- What should we use for the constant fountain mana regen?  Use -1 to keep the default dota behavior.
--FOUNTAIN_PERCENTAGE_MANA_REGEN = -1     -- What should we use for the percentage fountain mana regen?  Use -1 to keep the default dota behavior.
--FOUNTAIN_PERCENTAGE_HEALTH_REGEN = -1   -- What should we use for the percentage fountain health regen?  Use -1 to keep the default dota behavior.
MAXIMUM_ATTACK_SPEED = 1000              -- What should we use for the maximum attack speed?
MINIMUM_ATTACK_SPEED = 20               -- What should we use for the minimum attack speed?

GAME_END_DELAY = 60                     -- How long should we wait after the game winner is set to display the victory banner and End Screen?  Use -1 to keep the default (about 10 seconds)
VICTORY_MESSAGE_DURATION = 3            -- How long should we wait after the victory message displays to show the End Screen?  Use
DISABLE_DAY_NIGHT_CYCLE = true         -- Should we disable the day night cycle from naturally occurring? (Manual adjustment still possible)
DISABLE_KILLING_SPREE_ANNOUNCER = true -- Shuold we disable the killing spree announcer?
DISABLE_STICKY_ITEM = false             -- Should we disable the sticky item button in the quick buy area?
--SKIP_TEAM_SETUP = true                 -- Should we skip the team setup entirely?
--ENABLE_AUTO_LAUNCH = true               -- Should we automatically have the game complete team setup after AUTO_LAUNCH_DELAY seconds?
--AUTO_LAUNCH_DELAY = 0                  -- How long should the default team selection launch timer be?  The default for custom games is 30.  Setting to 0 will skip team selection.
--LOCK_TEAM_SETUP = true                 -- Should we lock the teams initially?  Note that the host can still unlock the teams


-- NOTE: You always need at least 2 non-bounty type runes to be able to spawn or your game will crash!
--ENABLED_RUNES = {}                      -- Which runes should be enabled to spawn in our game mode?
--ENABLED_RUNES[DOTA_RUNE_DOUBLEDAMAGE] = true
--ENABLED_RUNES[DOTA_RUNE_HASTE] = true
--ENABLED_RUNES[DOTA_RUNE_ILLUSION] = true
--ENABLED_RUNES[DOTA_RUNE_INVISIBILITY] = true
--ENABLED_RUNES[DOTA_RUNE_REGENERATION] = true
--ENABLED_RUNES[DOTA_RUNE_BOUNTY] = true
--ENABLED_RUNES[DOTA_RUNE_ARCANE] = true

--[[
MAX_NUMBER_OF_TEAMS = 1                -- How many potential teams can be in this game mode?
--USE_CUSTOM_TEAM_COLORS = true           -- Should we use custom team colors?
--USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS = true          -- Should we use custom team colors to color the players/minimap?


USE_AUTOMATIC_PLAYERS_PER_TEAM = true   -- Should we set the number of players to 10 / MAX_NUMBER_OF_TEAMS?

CUSTOM_TEAM_PLAYER_COUNT = {}           -- If we're not automatically setting the number of players per team, use this table
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 5
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_1] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_2] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_3] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_4] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_5] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_6] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_7] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_8] = 0
]]--