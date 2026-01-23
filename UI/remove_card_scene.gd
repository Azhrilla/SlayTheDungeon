extends Control
var m_cardHovered:Card = null
var m_selectedCard:Card = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cardName in GpState.m_cards:
		var newCard = CardFactory.createCard(cardName)
		newCard.setVisibleSide(Globals.visibleSide.FRONT)
		newCard.custom_minimum_size = Vector2(165,230)
		$ShowDeck/TextureRect/ScrollContainer/GridContainer.add_child(newCard)
		newCard.connect("mouseHoveredEnter",cardHoveredEnter)
		newCard.connect("mouseHoveredExit",cardHoveredExit)
		newCard.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_CENTER)

func _on_texture_button_pressed() -> void:
	if !m_selectedCard:
		return
	GpState.m_cards.erase(m_selectedCard.m_name)
	TransitionLayer.goToNextLevel()

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("click")) and m_cardHovered:
		if m_selectedCard:
			m_selectedCard.setCardState(Globals.cardState.DEFAULT)
		m_selectedCard = m_cardHovered
		m_cardHovered.setCardState(Globals.cardState.HOVERED)

func cardHoveredEnter(_card:Card):
	if _card != m_selectedCard:
		m_cardHovered = _card
		m_cardHovered.scale = Vector2(1.05,1.05)

func cardHoveredExit(_card:Card):
	if _card != m_selectedCard:
		m_cardHovered.setCardState(Globals.cardState.DEFAULT)
		m_cardHovered = null
