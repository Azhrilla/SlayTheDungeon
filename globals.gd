extends Node

enum cardTarget{ENEMY, NONE}
enum cardType{NORMAL,POWER}
enum cardPosition{DECK,HAND,DISCARD,NONE,POWER} 
enum type{HERO,MONSTER,NONE}
enum target{NONE,ALLY1,ALLY2,ALLY3,ENEMY1,ENEMY2,ENEMY3,ENEMY4}
enum cardState{DEFAULT,PLAYABLE,HOVERED}
enum statusType{NONE,ARMOR,SPIKE,DMG,STR,INTERRO,JUMP,BARRIER}
enum cardQuality{NONE,NORMAL,RARE,EPIC}

const m_playLevel = "res://Game/play_level.tscn"
const m_lootLevel = "res://UI/add_card_menu.tscn"
const m_victoryLevel = "res://UI/victory.tscn"
const m_removeCardLevel = "res://UI/remove_card_scene.tscn"
const m_basicChipList = ["Ramp","HealthPack","FirstStrike"]
var m_levels:Array[levelInfos] = []

func _ready() -> void:
	var mainMenu = levelInfos.new()
	
	var interlude1 = levelInfos.new()
	interlude1.m_lvlFile = "res://Interludes/act_1_bloc_1_scene_1.tscn"
	
	var interlude2 = levelInfos.new()
	interlude2.m_lvlFile = "res://Interludes/act_1_bloc_1_scene_2.tscn"
	
	var combat1 = levelInfos.new()
	combat1.m_lvlFile = m_playLevel
	combat1.m_enemies.append_array(["Drone","Drone","Drone","Drone"])#
	combat1.m_lootDollars = 50
	combat1.m_lootCardQuality = Globals.cardQuality.NORMAL
	combat1.m_goToLoot = true
	
	var combat11 = levelInfos.new()
	combat11.m_lvlFile = m_playLevel
	combat11.m_enemies.append_array(["Flame","Flame","Flame"])#
	combat11.m_lootDollars = 50
	combat11.m_lootCardQuality = Globals.cardQuality.NORMAL
	combat11.m_goToLoot = true
	
	var interlude3 = levelInfos.new()
	interlude3.m_lvlFile = "res://Interludes/act_1_bloc_1_scene_3.tscn"
	
	var combat2 = levelInfos.new()
	combat2.m_lvlFile = m_playLevel
	combat2.m_enemies.append_array(["Caillou","Caillou"])#
	combat2.m_lootDollars = 100
	combat2.m_lootCardQuality = Globals.cardQuality.NORMAL
	combat2.m_goToLoot = true
	
	var combat3 = levelInfos.new()
	combat3.m_lvlFile = m_playLevel
	combat3.m_enemies.append("Sniper")
	
	var victory = levelInfos.new()
	victory.m_lvlFile = Globals.m_victoryLevel
	
	mainMenu.m_nextLevel = interlude1
	interlude1.m_nextLevel = interlude2
	interlude2.m_nextLevel = combat1
	combat1.m_nextLevel = combat11
	combat11.m_nextLevel = interlude3
	interlude3.m_nextLevel = combat2
	combat2.m_nextLevel = combat3
	combat3.m_nextLevel = victory
	GpState.m_currentLevel = mainMenu
