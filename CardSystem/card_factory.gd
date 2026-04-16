extends Node

class_name CardFactory
const cardsScene = {
	"Card": preload("uid://baptagnhcl77s"),
	"Attack": preload("uid://dw6oiydwjwb3e"),
	"Defense" :preload("uid://dyq0lcnrhq6m6"),
	"Slash":preload("uid://3fxqcs2m533i"),
	"QuickSlash":preload("uid://kqkva0sk0kgr"),
	"Grab":preload("uid://dxmtb5pc7mb20"),
	"WindStrike": preload("uid://ditra7q8mmtqu"),
	"HugeStrike": preload("uid://cgsjxweas3i1y"),
	"SwiftAsTheWind": preload("uid://cykkqgaqkimv3"),
	"Barrier": preload("uid://dcpf13e56fxi4"),
	"DoubleUp":preload("uid://iuulxeyt146k"),
	"Laser":preload("uid://cecdyab21801d"),
	"Prepare":preload("uid://e10nn4cx5b4i"),
	"DurableArmor":preload("uid://d2tyjj0hn6isc"),
	"DrawBasic":preload("uid://c3vju8solj760"),
	"Scrambler":preload("uid://b7bf0csusig53"),
	"BasicTrap":preload("uid://cme5o34jshhj2"),
}

static func createCard(_id:String)->Card:
	var upgraded = false
	if _id.contains("+"):
		_id = _id.replace("+","")
		upgraded = true
	
	var newCard:Card = null
	if !cardsScene.has(_id):
		push_error ("Error: the card with name {} was not implemented".format(_id))
		newCard = cardsScene["Card"].instantiate()
	else:
		newCard = cardsScene[_id].instantiate()
	newCard.setUpgraded(upgraded)
	newCard.m_name = _id
	return newCard
	
