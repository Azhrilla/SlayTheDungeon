extends Node2D
class_name Player

var m_mouseOverButton:bool = false
var m_currentHandSize:int = 7
var m_currentDrawCount:int = 5
var m_hero:Hero = null


#Accessors
func getHero() -> Character:
	return m_hero

#SetUpLevel
func addCard(_card:Card)->void:
	$CardHolder.addCard(_card)
	_card.m_player = self

func attachHero():
	$Heroes.add_child(GpState.getHero())
	m_hero = GpState.m_hero
	GpState.getHero().connect("OnDeath", onHeroDeath)

func detachHeroes():
	$Heroes.remove_child(GpState.getHero())
	
	var objects = m_hero.getObjects()
	for object in objects:
		if object.get_parent():
			object.get_parent().remove_child(object)
		m_hero.add_child(object)

func onHeroDeath(_hero:Character):
	m_hero = null
	$Heroes.remove_child(_hero)
	MainUI.switchLevel("res://UI/defeat.tscn")

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
	m_hero.startCombat()

func startRound(_hero:Character,_monsters:Array[Character]):
	for cardCount in range(m_currentDrawCount):
		drawCard()
	m_hero.startRound(_hero,_monsters)

func endRound(_hero:Character,_monsters:Array[Character]):
	m_hero.endRound(_hero,_monsters)
	while $CardHolder.getCardCount(Globals.cardPosition.HAND) != 0:
		discardCard($CardHolder.getCardContainer(Globals.cardPosition.HAND)[0])

func getObjectInUse() -> ObjectBase:
	for object:ObjectBase in m_hero.getObjects():
		if object.getToggle():
			return object
	return null

func playCard(_card:Card,_targets:Array[Character],_targetPosition:Globals.target):
	var objectUsed:ObjectBase = getObjectInUse()
	if objectUsed:
		discardCard(_card)
		m_hero.useObject(_targets,objectUsed,_targetPosition)
		return

	var copyVectorTarget = _targets
	
	m_hero.cardPlayed(_card)
	
	_card.doWork(copyVectorTarget,m_hero,_targetPosition)
	if _card.m_cardType != Globals.cardType.POWER:
		$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.DISCARD)
	elif _card.m_cardType == Globals.cardType.POWER:
		$CardHolder.moveCard(_card,Globals.cardPosition.HAND,Globals.cardPosition.POWER)

func endCombat():
	m_hero.endCombat()

func processPowersWhenAttacking(_attack:atkObject) -> void:
	for card:Card in $CardHolder.getCardContainer(Globals.cardPosition.POWER):
		if card.has_method( "processPowersWhenAttacking"):
			card.processPowersWhenAttacking(_attack)
	m_hero.processAttacks(_attack)
