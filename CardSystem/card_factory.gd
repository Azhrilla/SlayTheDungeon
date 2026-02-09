extends Node

class_name CardFactory
const cardsScene = {
	"Card": preload("res://CardSystem/card.tscn"),
	"Attack": preload("res://Cards/attack.tscn"),
	"Defense" :preload("res://Cards/defense.tscn"),
	"Slash":preload("res://Cards/ts_quick_slash.tscn"),
	"QuickSlash":preload("res://Cards/attack_one.tscn"),
	"Grab":preload("res://Cards/ts_grab.tscn"),
	"WindStrike": preload("res://Cards/ts_wind_strike.tscn"),
	"HugeStrike": preload("res://Cards/ts_huge_strike.tscn"),
	"SwiftAsTheWind": preload("res://Cards/ts_swift_as_the_wind.tscn"),
	"Barrier": preload("res://Cards/ts_barrier.tscn"),
	"DoubleUp":preload("res://Cards/ts_double_up.tscn"),
	"Laser":preload("res://Cards/card_laser.tscn"),
	"Prepare":preload("res://Cards/card_prepare.tscn"),
	"DurableArmor":preload("res://Cards/card_durable_armor.tscn"),
	"DrawBasic":preload("res://Cards/card_draw_basic.tscn"),
}

static func createCard(_id:String)->Card:
	var newCard:Card = null
	if !cardsScene.has(_id):
		push_error ("Error: the card with name {} was not implemented".format(_id))
		newCard = cardsScene["Card"].instantiate()
	else:
		newCard = cardsScene[_id].instantiate()

	newCard.m_name = _id
	return newCard
	
