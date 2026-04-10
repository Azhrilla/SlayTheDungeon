extends CanvasLayer
signal endTurnPressed
signal cardShouldBePlayed(_card:Card,_target:Globals.target)


enum cardPlayMode{DEFAULT,PLAY,TARGET}

@onready var m_cardVisiblityComponent:CardsVisibilityComponent = $CardsVisibilityComponent
@onready var m_characterUIComponent:CharacterUIComponent = $CharactersUIComponent

var m_cardPlayMode = cardPlayMode.DEFAULT
var m_cardHovered:Card = null
var m_cardToPlay:Card = null
var m_cardPlayable = false
var m_mouseOnPlayZone = false
var m_mouseOnControl  = false
var m_savedTarget = null
var m_currentObject = null

func _ready() -> void:
	get_viewport().size_changed.connect(refreshUI)
	refreshUI()
	m_characterUIComponent.setDragMode(Globals.dragMod.NONE)
	$CombatUICharacter.init(GpState.m_hero)

	for object:ObjectBase in GpState.m_hero.getObjects():
		if object.get_parent():
			object.get_parent().remove_child(object)
		$ObjectContainer.add_child(object)
		object.isObjectToggled.connect(onObjectToggled)

func _exit_tree() -> void:
	$CombatUICharacter.release(GpState.m_hero)

func addTrap(_trap:TrapBase)->void:
	m_characterUIComponent.addTrap(_trap)

func setCharacters(_chars:Array[Character]) -> void:
	m_characterUIComponent.setCharacters(_chars)

func removeCharacter(_char:Character)->void:
	m_characterUIComponent.removeCharacter(_char)
	
func refreshUI() -> void:
	for card in m_cardVisiblityComponent.m_cards:
		m_cardVisiblityComponent.refreshCardVisibility(card)
	m_characterUIComponent.refreshPositions()

func setArrowToTarget(_origin,_target) -> void:
	$Arrow.position = (_origin + _target)/2
	$Arrow.look_at(_target)
	$Arrow.scale.x = (_target - _origin).length()/30

func handleDrag():
	var currentPosMouse:Vector2 = get_viewport().get_mouse_position() - m_cardHovered.custom_minimum_size/2
	m_cardHovered.position = currentPosMouse
	
	if m_mouseOnPlayZone:
		m_cardHovered.setCardState(Globals.cardState.PLAYABLE)
		m_cardPlayable = true
	else:
		m_cardHovered.setCardState(Globals.cardState.HOVERED)
		m_cardPlayable = false

func getCurrentTarget():
	return m_characterUIComponent.m_currentTarget

func getTargetType() -> Globals.cardTarget:
	if m_currentObject:
		return m_currentObject.getTargetType()
	if m_cardHovered:
		return m_cardHovered.getTargetType()
	return Globals.cardTarget.NONE

func setPlayMode(_playMode:cardPlayMode)->void:
	m_cardPlayMode = _playMode
	m_characterUIComponent.setCurrentTargetType(getTargetType())
	if _playMode == cardPlayMode.TARGET:
		m_characterUIComponent.showTargetingHelpers()
	else:
		for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
			m_characterUIComponent.hideTargetingHelpers()
			
func playCardInternal():
	cardShouldBePlayed.emit(m_cardToPlay,m_savedTarget)
	if m_currentObject:
		onObjectToggled(m_currentObject, false)
	m_cardToPlay.stopParticles()
	m_cardToPlay.scale = Vector2.ONE
	m_cardToPlay = null
	m_cardHovered = null
	$Arrow.visible = false
	m_characterUIComponent.setDragMode(Globals.dragMod.NONE)
	setPlayMode(cardPlayMode.DEFAULT)
	m_cardVisiblityComponent.reorganizeHandPositions(m_cardHovered)

func playCard():
	m_savedTarget = getCurrentTarget()
	m_cardToPlay.playCardAnim($PlayedCardPosed.position,playCardInternal)

func _process(_delta: float) -> void:
	refreshUI()
	if !m_cardHovered:
		setPlayMode(cardPlayMode.DEFAULT)

	if m_cardPlayMode == cardPlayMode.DEFAULT:
		if (Input.is_action_pressed("click")) and m_cardHovered:
			handleDrag()

		if (Input.is_action_just_released("click")) and m_cardHovered:
			if m_cardPlayable:
				m_cardToPlay = m_cardHovered
				if getTargetType() != Globals.cardTarget.NONE:
					m_cardHovered.setGlobalPosition($PlayedCardPosed.position)
					setPlayMode(cardPlayMode.TARGET)
				else:
					playCard()

	if m_cardPlayMode == cardPlayMode.TARGET:
		m_characterUIComponent.setDragMode(Globals.dragMod.TARGET)
		var currentPosMouse:Vector2 = get_viewport().get_mouse_position() 
		var targetArrow = currentPosMouse
		if getCurrentTarget():
			targetArrow = m_characterUIComponent.getMonsterPosition(getCurrentTarget())
		setArrowToTarget(m_characterUIComponent.getPlayerPosition(),targetArrow)
		$Arrow.visible = true
		
		if (Input.is_action_pressed("click")) and getCurrentTarget():
			playCard()
	
func addCard(_card:Card)->void:
	m_cardVisiblityComponent.addCard(_card)
	_card.connect("mouseHoveredEnter",cardHoveredEnter)
	_card.connect("mouseHoveredExit",cardHoveredExit)
	_card.connect("cardNeedUIRefresh",cardNeedUIRefresh)

func cardHoveredEnter(_card:Card):
	if m_cardHovered == null:
		m_cardHovered = _card
		m_cardHovered.setCardState(Globals.cardState.HOVERED)
	if !Input.is_action_pressed("click"):
		m_cardVisiblityComponent.reorganizeHandPositions(m_cardHovered)

func cardHoveredExit(_card:Card):
	if _card == m_cardHovered and !Input.is_action_pressed("click"):
		m_cardHovered.setCardState(Globals.cardState.DEFAULT)
		m_cardHovered = null
		m_cardVisiblityComponent.reorganizeHandPositions(m_cardHovered)

func cardNeedUIRefresh(_card:Card):
	_card.setCardState(Globals.cardState.DEFAULT)
	m_cardVisiblityComponent.refreshCardVisibility(_card)
	m_cardVisiblityComponent.reorganizeHandPositions(m_cardHovered)

func _on_end_turn_button_pressed() -> void:
	endTurnPressed.emit()

func _on_play_zone_mouse_exited() -> void:
	if !m_mouseOnControl:
		m_mouseOnPlayZone = false

func _on_play_zone_mouse_entered() -> void:
	m_mouseOnPlayZone = true

func onObjectToggled(_object:ObjectBase, _toggle:bool)->void:
	if _toggle == false:
		m_currentObject = null
		_object.setToggle(_toggle)
		return
	
	if GpState.m_hero.canObjectBeUsed(_object):
		m_currentObject = _object
	else:
		_object.setToggle(false)

func hideDeck(_zoneType:Globals.cardPosition)->void:
	m_characterUIComponent.showCharacters()
	$EndTurnButton.disabled = false
	m_cardVisiblityComponent.hideDeck(_zoneType)

func showDeck(_zoneType:Globals.cardPosition)->void:
	m_characterUIComponent.hideCharacters()
	$EndTurnButton.disabled = true
	m_cardVisiblityComponent.showDeck(_zoneType)

func _on_draw_button_pressed() -> void:
	if m_cardVisiblityComponent.m_currentlyShownDeck == Globals.cardPosition.DECK:
		hideDeck(Globals.cardPosition.DECK)
	else:
		showDeck(Globals.cardPosition.DECK)

func _on_discard_button_pressed() -> void:
	if m_cardVisiblityComponent.m_currentlyShownDeck == Globals.cardPosition.DISCARD:
		hideDeck(Globals.cardPosition.DISCARD)
	else:
		showDeck(Globals.cardPosition.DISCARD)
