extends Node2D
class_name Player



var m_mouseOverButton:bool = false
var m_currentHandSize:int = 7
var m_currentDrawCount:int = 5
var m_heroes: Array[Character] = []



#Accessors
func getHeroes() -> Array[Character]:
	return m_heroes

#SetUpLevel
func addCard(_card:Card)->void:
	$CardHolder.addCard(_card)
	_card.m_player = self

func attachHero():
	$Heroes.add_child(GpState.m_hero)
	m_heroes.append(GpState.m_hero)
	GpState.m_hero.connect("OnDeath", onHeroDeath)

func detachHeroes():
	$Heroes.remove_child(GpState.m_hero)

func onHeroDeath(_hero:Character):
	m_heroes.erase(_hero)
	$Heroes.remove_child(_hero)
	if m_heroes.is_empty():
		TransitionLayer.switchLevel("res://UI/defeat.tscn")

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	attachHero()
	
#GamePlay Functions
func drawCard():
	if $CardHolder.getCardCount(Globals.cardPosition.HAND) < m_currentHandSize:
		$CardHolder.drawCard()
	else:
		$CardHolder.drawCard(Globals.cardPosition.DISCARD)

func shuffle():
	$CardHolder.shuffle()
	
func discardCard(_card:Card):
	$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.DISCARD)

func startCombat():
	for hero in m_heroes:
		hero.startCombat()

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	for cardCount in range(m_currentDrawCount):
		drawCard()
	for hero in m_heroes:
		hero.startRound(_heroes,_monsters)

func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	while $CardHolder.getCardCount(Globals.cardPosition.HAND) != 0:
		discardCard($CardHolder.getCardContainer(Globals.cardPosition.HAND)[0])

func playCard(_card:Card,_targets:Array[Character],_targetPosition:Globals.target):
	for hero in m_heroes:
		hero.cardPlayed(_card)
	
	_card.doWork(_targets,m_heroes,_targetPosition)
	if _card.m_cardType == Globals.cardType.NORMAL:
		$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.DISCARD)
	elif _card.m_cardType == Globals.cardType.POWER:
		$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.POWER)

func endCombat():
	for hero in m_heroes:
		hero.endCombat()

func processPowersWhenAttacking(_attack:atkObject) -> void:
	for card:Card in $CardHolder.getCardContainer(Globals.cardPosition.POWER):
		if card.has_method( "processPowersWhenAttacking"):
			card.processPowersWhenAttacking(_attack)
	for hero in m_heroes:
		hero.processAttacks(_attack)
