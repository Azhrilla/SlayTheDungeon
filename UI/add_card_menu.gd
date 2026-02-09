extends Control

var m_cardNames:Array[String] = []
var m_UIReady = false
var m_cardHovered = null
var m_cardChosen = null


func _ready() -> void:
	if GpState.getCurrentLevel().m_lootDollars > 0:
		GpState.m_currentDollars += GpState.getCurrentLevel().m_lootDollars
		var text = "You found {dolls} dollars and can add a new card.".format({"dolls": str(GpState.getCurrentLevel().m_lootDollars)})
		$BackGround/TextureRect/VBoxContainer/Label.text = text
	GpState.getCurrentLevel().m_goToLoot = false	
	m_cardNames = Globals.getCardsLoot()

	
func setUpLevel():
	if !m_UIReady:
			var boxSet = $BackGround/TextureRect/VBoxContainer/HBoxContainer.get_children()
			for index in range(m_cardNames.size()):
				var newCard = CardFactory.createCard(m_cardNames[index])
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
	MainUI.goToNextLevel()
		
func _on_take_no_card_pressed() -> void:
	MainUI.goToNextLevel()
