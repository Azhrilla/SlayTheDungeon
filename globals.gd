extends Node

enum cardTarget{ENEMY, NONE, EMPTY, ANY, CARD}
enum cardType{NORMAL,POWER, TRAP}
enum cardPosition{DECK,HAND,DISCARD,NONE,POWER} 
enum type{HERO,MONSTER,NONE}
enum target{NONE,ALLY1,ALLY2,ALLY3,ENEMY1,ENEMY2,ENEMY3,ENEMY4}
enum cardState{DEFAULT,PLAYABLE,HOVERED}
enum statusType{NONE,ARMOR,SPIKE,DMG,STR,INTERRO,JUMP,BARRIER,POISON}
enum cardQuality{NONE,NORMAL,RARE,EPIC}
enum dragMod{NONE,TARGET,PLAY}

const m_playLevel = "res://Game/play_level.tscn"
const m_lootLevel = "res://UI/add_card_menu.tscn"
const m_victoryLevel = "res://UI/victory.tscn"
const m_removeCardLevel = "res://UI/remove_card_scene.tscn"
const m_basicChipList = ["Ramp","HealthPack","FirstStrike"]
const m_godMode = false

static var m_availableChips = {
	Globals.cardQuality.NORMAL : {"Price":[50,100],"Chips":["Ramp","HealthPack","FirstStrike"]},
}

static var m_availableCards = {
	Globals.cardQuality.NORMAL : ["BasicTrap","WindStrike","HugeStrike","SwiftAsTheWind","DoubleUp","Laser","Prepare","DurableArmor","Scrambler"],
	Globals.cardQuality.RARE : ["Barrier","DrawBasic"],
}

static var m_buyCost = {
	Globals.cardQuality.NORMAL : [50,100],
	Globals.cardQuality.RARE : [150,200],
}

func getCardsLoot() -> Array[String]:
	var currentQuality = GpState.getCurrentLevel().m_lootCardQuality
	var output:Array[String]
	while output.size() < 3:
		var newCard = m_availableCards[currentQuality].pick_random()
		if output.find(newCard) == -1:
			output.append(newCard)
	return output
