extends Control

var m_cardNames:Array[String] = ["WindStrike","HugeStrike","SwiftAsTheWind"]
var m_UIReady = false
var m_cardHovered = null
var m_cardChosen = null


func _ready() -> void:
	if GpState.m_currentLevel.m_lootDollars > 0:
		GpState.m_currentDollars += GpState.m_currentLevel.m_lootDollars
	GpState.m_currentLevel.m_goToLoot = false
	
func setUpLevel():
	if !m_UIReady:
			var boxSet = $BackGround/TextureRect/VBoxContainer/HBoxContainer.get_children()
			for index in range(m_cardNames.size()):
				var newCard = CardFactory.createCard(m_cardNames[index])
				newCard.setVisibleSide(Globals.visibleSide.FRONT)
				boxSet[index].add_child(newCard)
				newCard.connect("mouseHoveredEnter",cardHoveredEnter)
				newCard.connect("mouseHoveredExit",cardHoveredExit)
			m_UIReady = true

func _process(_delta: float) -> void:
	setUpLevel()
	if (Input.is_action_just_pressed("click")) and m_cardHovered:
		m_cardHovered.setCardState(Globals.cardState.PLAYABLE)
		if m_cardChosen:
			m_cardChosen.setCardState(Globals.cardState.DEFAULT)
		m_cardChosen = m_cardHovered

func cardHoveredEnter(_card:Card):
	m_cardHovered = _card
	if _card != m_cardChosen:
		_card.setCardState(Globals.cardState.HOVERED)

func cardHoveredExit(_card:Card):
	m_cardHovered = null
	if _card != m_cardChosen:
		_card.setCardState(Globals.cardState.DEFAULT)

func _on_select_card_pressed() -> void:
	if !m_cardChosen:
		return
	
	GpState.m_cards.append(m_cardChosen.m_name)
	TransitionLayer.goToNextLevel()
		
func _on_take_no_card_pressed() -> void:
	TransitionLayer.goToNextLevel()
