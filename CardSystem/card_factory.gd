extends Node

class_name CardFactory
const cardScene:PackedScene = preload("res://CardSystem/card.tscn")
const attack_scene:PackedScene = preload("res://Cards/attack.tscn")
const defense_scene:PackedScene = preload("res://Cards/defense.tscn")
const TS_quickSlash:PackedScene = preload("res://Cards/ts_quick_slash.tscn")
const attackone_scene:PackedScene = preload("res://Cards/attack_one.tscn")
const TS_grab:PackedScene = preload("res://Cards/ts_grab.tscn")
const TS_windStrike:PackedScene = preload("res://Cards/ts_wind_strike.tscn")
const TS_hugeStrike:PackedScene = preload("res://Cards/ts_huge_strike.tscn")
const TS_swiftAsTheWind:PackedScene = preload("res://Cards/ts_swift_as_the_wind.tscn")

static func createCard(_id:String)->Card:
	var newCard:Card = null
	match _id:
		"Attack":
			newCard = attack_scene.instantiate()
		"Defense":
			newCard = defense_scene.instantiate()
		"Slash":
			newCard = attackone_scene.instantiate()
		"QuickSlash":
			newCard = TS_quickSlash.instantiate()
		"Grab":
			newCard = TS_grab.instantiate()
		"WindStrike":
			newCard = TS_windStrike.instantiate()
		"HugeStrike":
			newCard = TS_hugeStrike.instantiate()
		"SwiftAsTheWind":
			newCard = TS_swiftAsTheWind.instantiate()
		"_":
			push_error ("Error: the card with name {} was not implemented".format(_id))
			newCard = cardScene.instantiate()
	newCard.m_name = _id
	return newCard
	
