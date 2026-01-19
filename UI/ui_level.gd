extends CanvasLayer

signal endTurnPressed
signal cardShouldBePlayed(_card:Card,_target:Globals.target)

enum dragMod{NONE,TARGET,PLAY}

var m_cards:Array[Card] = []
var m_cardHovered = null
var m_originalPositionHoveredCard:Vector2 = Vector2.ZERO
var m_cardPlayable = false
var m_characters:Array[Character] = []
var m_mouseOnPlayZone = false
var m_mouseOnControl  = false
var m_hoveredLastPosition:Vector2 = Vector2.ZERO
var m_currentTargetArrow:Vector2 = Vector2.ZERO
var m_dragMode:dragMod = dragMod.NONE
var m_currentTarget:Globals.target = Globals.target.NONE
var m_currentlyShownDeck:Globals.cardPosition = Globals.cardPosition.NONE

func _ready() -> void:
	$ShowDeck/TextureRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ShowDeck/TextureRect/ScrollContainer/GridContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ShowDeck/TextureRect/ScrollContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_viewport().size_changed.connect(refreshUI)
	refreshUI()
	setDragMode(dragMod.NONE)

func setCharacters(_chars:Array[Character]) -> void:
	m_characters = _chars

func getMonsterPosition(_pos:Globals.target)->Vector2:
	var currentBox = $Enemies/MonsterBox/Control
	
	match _pos:
		Globals.target.ENEMY1:
			currentBox = $Enemies/MonsterBox/Control
		Globals.target.ENEMY2:
			currentBox = $Enemies/MonsterBox/Control2
		Globals.target.ENEMY3:
			currentBox = $Enemies/MonsterBox/Control3
		Globals.target.ENEMY4:
			currentBox = $Enemies/MonsterBox/Control4
		_:
			push_error("Trying to get position of a monster with position higher than 3")
	return currentBox.global_position + currentBox.custom_minimum_size/2
	
func refreshUI() -> void:
	for card in m_cards:
		setVisibilityAndPosition(card)
	for character in m_characters:
		if character.m_type == Globals.type.HERO:
			character.position = $PlayerPos.position
		if character.m_type == Globals.type.MONSTER:
			character.position = getMonsterPosition(character.m_currentPosition)

func setVisibilityAndPosition(_card:Card)->void:
	if m_currentlyShownDeck == Globals.cardPosition.NONE:
		if (_card.m_currentPosition == Globals.cardPosition.HAND):
			_card.visible = true
		else:
			_card.visible = false
	
	var cards = getCardsInPosition(m_currentlyShownDeck)
	var controlNodes = $ShowDeck/TextureRect/ScrollContainer/GridContainer.get_children()
	for index in range(cards.size()):
		
		#controlNodes[index].force_update_transform()
		cards[index].visible = true
		cards[index].global_position = controlNodes[index].global_position + controlNodes[index].custom_minimum_size/2
	

func setArrowToTarget(_origin,_target) -> void:
	$Arrow.position = (_origin + _target)/2
	$Arrow.look_at(_target)
	$Arrow.scale.x = (_target - _origin).length()/30

func setDragMode(_dragMod:dragMod):
	m_dragMode = _dragMod
	$Enemies.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Enemies/MonsterBox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if m_dragMode == dragMod.TARGET:
		for character in m_characters:
			if character.m_currentPosition == Globals.target.ENEMY1:
				$Enemies/MonsterBox/Control.mouse_filter = Control.MOUSE_FILTER_STOP
			if character.m_currentPosition == Globals.target.ENEMY2:
				$Enemies/MonsterBox/Control2.mouse_filter = Control.MOUSE_FILTER_STOP
			if character.m_currentPosition == Globals.target.ENEMY3:
				$Enemies/MonsterBox/Control3.mouse_filter = Control.MOUSE_FILTER_STOP
			if character.m_currentPosition == Globals.target.ENEMY4:
				$Enemies/MonsterBox/Control4.mouse_filter = Control.MOUSE_FILTER_STOP	
	else:
		$Enemies/MonsterBox/Control.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$Enemies/MonsterBox/Control2.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$Enemies/MonsterBox/Control3.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$Enemies/MonsterBox/Control4.mouse_filter = Control.MOUSE_FILTER_IGNORE	
		
func handleDrag():
	var currentPosMouse:Vector2 = get_viewport().get_mouse_position()
	#m_cardHovered.mouse_filter = 0
	if m_dragMode == dragMod.PLAY:
		if m_mouseOnPlayZone:
			m_hoveredLastPosition = currentPosMouse
			$Arrow.visible = false
			
	if m_dragMode == dragMod.TARGET:
		var targetArrow = currentPosMouse
		if m_currentTargetArrow != Vector2.ZERO:
			targetArrow = m_currentTargetArrow
		setArrowToTarget(m_hoveredLastPosition,targetArrow)
		$Arrow.visible = true
		
	if m_mouseOnPlayZone:
		m_cardHovered.setCardState(Globals.cardState.PLAYABLE)
		m_cardPlayable = true
		m_cardHovered.position = m_hoveredLastPosition
	else:
		m_currentTargetArrow = Vector2.ZERO
		$Arrow.visible = false
		m_hoveredLastPosition = currentPosMouse
		m_cardHovered.setCardState(Globals.cardState.HOVERED)
		m_cardPlayable = false
		m_cardHovered.position = m_hoveredLastPosition

func _process(_delta: float) -> void:
	reorganizeHandPositions()		
	refreshUI()
	
	if (Input.is_action_pressed("click")) and m_cardHovered:
		if m_cardHovered.needTarget():
			setDragMode(dragMod.TARGET)
		else:
			setDragMode(dragMod.PLAY)
		
		handleDrag()

	if (Input.is_action_just_released("click")) and m_cardHovered:
		if m_cardPlayable:
			if (m_dragMode == dragMod.TARGET and m_currentTarget != Globals.target.NONE) or m_dragMode == dragMod.PLAY:
				cardShouldBePlayed.emit(m_cardHovered,m_currentTarget)
		m_cardHovered.stopParticles()
		m_cardHovered.scale = Vector2.ONE
		m_cardHovered = null
		$Arrow.visible = false
		setDragMode(dragMod.NONE)
	
func addCard(_card:Card)->void:
	$Cards.add_child(_card)
	m_cards.append(_card)
	_card.setVisibleSide(Globals.visibleSide.FRONT)
	_card.connect("mouseHoveredEnter",cardHoveredEnter)
	_card.connect("mouseHoveredExit",cardHoveredExit)
	_card.connect("cardNeedUIRefresh",cardNeedUIRefresh)
	if m_cards.size() > $ShowDeck/TextureRect/ScrollContainer/GridContainer.get_child_count():
		var newControl = Control.new()
		#TextureRect.texture = "res://Graphics/pngtree-sci-fi-trading-card-game-template-minimalistic-bright-theme-white-background-png-image_17761343.webp"
		newControl.custom_minimum_size = Vector2(150,220)
		$ShowDeck/TextureRect/ScrollContainer/GridContainer.add_child(newControl)
		newControl.mouse_filter = 2

func getCardsInPosition(_position:Globals.cardPosition) -> Array[Card]:
	var output:Array[Card] = []
	for card in m_cards:
		if card.m_currentPosition == _position:
			output.append(card)
	return output

func reorganizeHandPositions(_processHovered:bool=false):
	var cardsInHand = getCardsInPosition(Globals.cardPosition.HAND)
	var cardCount = cardsInHand.size()
	var leftCardMarkerPos = $HandLeft.position
	var rightCardMarkerPos = $HandRight.position
	var hoveredCardSeen = false
	for indexCard in range(cardCount):
		var modifiedIndex:int = indexCard+1
		var currentCard:Card = cardsInHand[indexCard]
		
		if m_cardHovered:
			if hoveredCardSeen:
				modifiedIndex+=1
			else:
				modifiedIndex-=1
			if currentCard == m_cardHovered:
				modifiedIndex+=1
				hoveredCardSeen = true

		currentCard.position = leftCardMarkerPos + (modifiedIndex+1)* ((rightCardMarkerPos-leftCardMarkerPos)/ (cardCount+3))

func cardHoveredEnter(_card:Card):
	var cardsInHand = getCardsInPosition(Globals.cardPosition.HAND)
	var indexCardInHand:int = cardsInHand.find(_card)
	if indexCardInHand < 0:
		return	
	if m_cardHovered == null:
		m_cardHovered = _card
		m_originalPositionHoveredCard = m_cardHovered.position
		m_cardHovered.setCardState(Globals.cardState.HOVERED)

func cardHoveredExit(_card:Card):
	if _card == m_cardHovered and !Input.is_action_pressed("click"):
		m_cardHovered.setCardState(Globals.cardState.DEFAULT)
		m_cardHovered = null

func cardNeedUIRefresh(_card:Card):
	_card.setCardState(Globals.cardState.DEFAULT)
	setVisibilityAndPosition(_card)

func _on_end_turn_button_pressed() -> void:
	endTurnPressed.emit()

func _on_play_zone_mouse_exited() -> void:
	if !m_mouseOnControl:
		m_mouseOnPlayZone = false

func _on_play_zone_mouse_entered() -> void:
	m_mouseOnPlayZone = true

func isTargetControlZoneEmpty(_target:Globals.target)->bool:
	for character in m_characters:
		if character.m_currentPosition == _target:
			return false
	return true

func setEnteredTargetControlZone(_target:Globals.target)->void:
	if isTargetControlZoneEmpty(_target):
		return
	m_currentTarget = _target
	m_currentTargetArrow = getMonsterPosition(_target)
	m_mouseOnControl = true
	m_mouseOnPlayZone = true

func exitControlZone() -> void:
	m_currentTarget = Globals.target.NONE
	m_currentTargetArrow = Vector2.ZERO
	m_mouseOnControl = false

func _on_control_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY1)

func _on_control_2_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY2)

func _on_control_3_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY3)

func _on_control_4_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY4)

func _on_control_mouse_exited() -> void:
	exitControlZone()

func _on_control_2_mouse_exited() -> void:
	exitControlZone()

func _on_control_3_mouse_exited() -> void:
	exitControlZone()

func _on_control_4_mouse_exited() -> void:
	exitControlZone()

func hideDeck(_zoneType:Globals.cardPosition)->void:
	for character in m_characters:
		character.visible = true
	for card in getCardsInPosition(Globals.cardPosition.HAND):
		card.visible = true
	
	$ShowDeck.visible = false
	
	for card in getCardsInPosition(_zoneType):
		card.visible = false
		card.get_parent().remove_child(card)
		$Cards.add_child(card)
		card.mouse_filter = Control.MOUSE_FILTER_PASS
	
	var cardsArray = getCardsInPosition(_zoneType)
	var cardCount:int = cardsArray.size()
	for index in range(cardCount):
		cardsArray[index].visible = false
		
func showDeck(_zoneType:Globals.cardPosition)->void:
	$ShowDeck.visible = true
	for character in m_characters:
		character.visible = false	
	for card in getCardsInPosition(Globals.cardPosition.HAND):
		card.visible = false
	
	var index = 0
	var controlNodes = $ShowDeck/TextureRect/ScrollContainer/GridContainer.get_children()
	for card in getCardsInPosition(_zoneType):
		card.visible = false
		card.get_parent().remove_child(card)
		controlNodes[index].add_child(card)
		index +=1

func _on_draw_button_pressed() -> void:
	if m_currentlyShownDeck == Globals.cardPosition.NONE:
		m_currentlyShownDeck = Globals.cardPosition.DECK
		showDeck(Globals.cardPosition.DECK)
	elif m_currentlyShownDeck == Globals.cardPosition.DECK:
		hideDeck(Globals.cardPosition.DECK)
		m_currentlyShownDeck = Globals.cardPosition.NONE

func _on_discard_button_pressed() -> void:
	if m_currentlyShownDeck == Globals.cardPosition.NONE:
		m_currentlyShownDeck = Globals.cardPosition.DISCARD
		showDeck(Globals.cardPosition.DISCARD)
	elif m_currentlyShownDeck == Globals.cardPosition.DISCARD:
		hideDeck(Globals.cardPosition.DISCARD)
		m_currentlyShownDeck = Globals.cardPosition.NONE
