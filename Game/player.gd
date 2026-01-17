extends Node2D
class_name Player

const heroScene:PackedScene = preload("res://Game/hero.tscn")

var m_mouseOverButton:bool = false
var m_currentHandSize:int = 5
var m_heroes: Array[Character] = []

#Accessors
func getHeroes() -> Array[Character]:
	return m_heroes

#SetUpLevel
func addCard(_card:Card)->void:
	$CardHolder.addCard(_card)
	_card.m_player = self

func createHero():
	var newHero = heroScene.instantiate()
	$Heroes.add_child(newHero)
	m_heroes.append(newHero)
	newHero.connect("OnDeath", onHeroDeath)

func onHeroDeath(_hero:Character):
	m_heroes.erase(_hero)
	$Heroes.remove_child(_hero)
	if m_heroes.is_empty():
		TransitionLayer.switchLevel("res://UI/defeat.tscn")

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	createHero()
	
#GamePlay Functions
func drawCard():
	$CardHolder.drawCard()

func shuffle():
	$CardHolder.shuffle()

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	for cardCount in range(m_currentHandSize):
		drawCard()
	for hero in m_heroes:
		hero.startRound(_heroes,_monsters)

func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	pass

func playCard(_card:Card,_targets:Array[Character],_targetPosition:Globals.target):
	_card.doWork(_targets,m_heroes,_targetPosition)
	if _card.m_cardType == Globals.cardType.NORMAL:
		$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.DISCARD)
	elif _card.m_cardType == Globals.cardType.POWER:
		$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.POWER)

func processPowersWhenAttacking(_attack:atkObject) -> void:
	for card:Card in $CardHolder.getCardContainer(Globals.cardPosition.POWER):
		if card.has_method( "processPowersWhenAttacking"):
			card.processPowersWhenAttacking(_attack)
