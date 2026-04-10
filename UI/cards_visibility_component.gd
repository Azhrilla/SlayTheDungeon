extends Control
class_name CardsVisibilityComponent

var m_currentlyShownDeck:Globals.cardPosition = Globals.cardPosition.NONE
var m_cards:Array[Card] = []

func reorganizeHandPositions(_cardHovered:Card):	
	var cardsInHand = getCardsInPosition(Globals.cardPosition.HAND)	
	var cardCount = cardsInHand.size()
	var leftCardMarkerPos = $HandLeft.position
	var rightCardMarkerPos = $HandRight.position
	var hoveredCardSeen = false
	for indexCard in range(cardCount):
		var modifiedIndex:int = indexCard+1
		var currentCard:Card = cardsInHand[indexCard]
		
		if _cardHovered:
			if hoveredCardSeen:
				modifiedIndex+=1
			else:
				modifiedIndex-=1
			if currentCard == _cardHovered:
				modifiedIndex+=1
				hoveredCardSeen = true
		if currentCard != _cardHovered:
			currentCard.setGlobalPosition(leftCardMarkerPos + (modifiedIndex+0.5)* ((rightCardMarkerPos-leftCardMarkerPos)/ (cardCount+3)))
		else:
			var globaPos = leftCardMarkerPos + (modifiedIndex+0.5)* ((rightCardMarkerPos-leftCardMarkerPos)/ (cardCount+3))
			globaPos.y = $HandTop.global_position.y
			currentCard.setGlobalPosition(globaPos)
			
func _process(_delta: float) -> void:
	if m_currentlyShownDeck != Globals.cardPosition.HAND:
		var cards = getCardsInPosition(m_currentlyShownDeck)
		var controlNodes = $ShowDeck/TextureRect/ScrollContainer/GridContainer.get_children()
		for index in range(cards.size()):
			cards[index].visible = true
			cards[index].global_position = controlNodes[index].global_position

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ShowDeck.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ShowDeck/TextureRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ShowDeck/TextureRect/ScrollContainer/GridContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ShowDeck/TextureRect/ScrollContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE

func refreshCardVisibility(_card:Card)->void:
	if (_card.m_currentPosition == Globals.cardPosition.HAND):
		_card.visible = true
	else:
		_card.visible = false

func getCardsInPosition(_position:Globals.cardPosition) -> Array[Card]:
	var output:Array[Card] = []
	for card in m_cards:
		if card.m_currentPosition == _position:
			output.append(card)
	return output

func addCard(_card:Card):
	$Cards.add_child(_card)
	m_cards.append(_card)
	if m_cards.size() > $ShowDeck/TextureRect/ScrollContainer/GridContainer.get_child_count():
		var newControl = Control.new()
		newControl.custom_minimum_size = Vector2(150,220)
		$ShowDeck/TextureRect/ScrollContainer/GridContainer.add_child(newControl)
		newControl.mouse_filter = 2

func showDeck(_zoneType:Globals.cardPosition)->void:
	if m_currentlyShownDeck != Globals.cardPosition.NONE:
		hideDeck(m_currentlyShownDeck)
	
	m_currentlyShownDeck = _zoneType
	$ShowDeck.visible = true
	
	
	for card in getCardsInPosition(Globals.cardPosition.HAND):
		card.visible = false
	var index = 0
	var controlNodes = $ShowDeck/TextureRect/ScrollContainer/GridContainer.get_children()
	for card in getCardsInPosition(_zoneType):
		card.visible = false
		card.get_parent().remove_child(card)
		controlNodes[index].add_child(card)
		index +=1

func hideDeck(_zoneType:Globals.cardPosition)->void:
	$ShowDeck.visible = false
	
	for card in getCardsInPosition(Globals.cardPosition.HAND):
		card.visible = true
	
	for card in getCardsInPosition(_zoneType):
		card.visible = false
		card.get_parent().remove_child(card)
		$Cards.add_child(card)
		card.mouse_filter = Control.MOUSE_FILTER_PASS
	
	var cardsArray = getCardsInPosition(_zoneType)
	var cardCount:int = cardsArray.size()
	for index in range(cardCount):
		cardsArray[index].visible = false
	m_currentlyShownDeck = Globals.cardPosition.NONE
	
	
	
