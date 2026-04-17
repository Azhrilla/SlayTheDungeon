extends Control

var m_cardHovered:Card = null
var m_cardChosen:Card = null

var m_chipHovered:Chip = null
var m_chipChosen:Chip = null

var rng:RandomNumberGenerator = RandomNumberGenerator.new()

static var m_availableCards = {
	Globals.cardQuality.NORMAL : 5,
	Globals.cardQuality.RARE : 1,
}

static var m_availableChips = {
	Globals.cardQuality.NORMAL : 3,
	Globals.cardQuality.RARE : 0,
}

func initCardPanel()->void:
	var cardContainer = $TextureRect/TabContainer/Cards/CardsContainer
	for quality in Globals.m_availableCards.keys():
		for index in range(0,m_availableCards[quality]):
			var buyCost = rng.randi_range(Globals.m_buyCost[quality][0],Globals.m_buyCost[quality][1])
			var newCardControl = VBoxContainer.new()
			newCardControl.mouse_filter = Control.MOUSE_FILTER_IGNORE
			cardContainer.add_child(newCardControl)
			newCardControl.custom_minimum_size = Vector2(200,250)
			var cardName = Globals.m_availableCards[quality].pick_random()
			var newCard:Card = CardFactory.createCard(cardName)
			newCard.m_buyCost = buyCost
			newCardControl.add_child(newCard)
			var buffer = Control.new()
			buffer.custom_minimum_size = Vector2(1,30)
			newCardControl.add_child(buffer)
			var newLabel = Label.new()
			newLabel.text ="Cost: "+ str(buyCost)
			newLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			newCardControl.add_child(newLabel)
			newCard.connect("mouseHoveredEnter",cardHoveredEnter)
			newCard.connect("mouseHoveredExit",cardHoveredExit)


func initChipPanel()->void:
	var chipContainer = $TextureRect/TabContainer/Chips/ChipContainer
	
	for quality in Globals.m_availableChips.keys():
		var availableChips = GpState.getAvailableChips(quality)
		for index in range(0,m_availableChips[quality]):
			if availableChips.is_empty():
				break
				
			var chipName = availableChips.pick_random()
			availableChips.erase(chipName)
			var buyCost = rng.randi_range(Globals.m_availableChips[quality]["Price"][0],Globals.m_availableChips[quality]["Price"][1])
			
			var newChipControl = VBoxContainer.new()
			newChipControl.mouse_filter = Control.MOUSE_FILTER_IGNORE
			newChipControl.custom_minimum_size = Vector2(200,200)
			chipContainer.add_child(newChipControl)
			
			var bufferStoreChip = CenterContainer.new()
			bufferStoreChip.mouse_filter = Control.MOUSE_FILTER_IGNORE
			bufferStoreChip.custom_minimum_size = Vector2(200,200)
			newChipControl.add_child(bufferStoreChip)

			var newChip:Chip = ChipFactory.createChip(chipName)
			newChip.m_buyCost = buyCost
			bufferStoreChip.add_child(newChip)
			newChip.custom_minimum_size = Vector2(120,120)
			newChip.mouseEntered.connect(mouseEnteredChip)
			newChip.mouseExited.connect(mouseExitedChip)
			
			var buffer = Control.new()
			buffer.custom_minimum_size = Vector2(1,10)
			newChipControl.add_child(buffer)
			
			var nameLabel = Label.new()
			nameLabel.text =chipName
			nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			newChipControl.add_child(nameLabel)

			var newLabel = Label.new()
			newLabel.text = "Cost: "+ str(buyCost)
			newLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			newChipControl.add_child(newLabel)

			
func _exit_tree() -> void:
	$CombatUICharacter.release(GpState.getHero())

func _ready() -> void:
	initCardPanel()
	initChipPanel()
	$CombatUICharacter.init(GpState.getHero())
	
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("click")) and m_cardHovered:
		if !m_cardChosen:
			m_cardHovered.setCardState(Globals.cardState.PLAYABLE)
			m_cardChosen = m_cardHovered
		elif m_cardChosen == m_cardHovered:
			m_cardChosen.setCardState(Globals.cardState.HOVERED)
			m_cardChosen = null
		elif m_cardChosen != m_cardHovered:
			m_cardHovered.setCardState(Globals.cardState.PLAYABLE)
			m_cardChosen.setCardState(Globals.cardState.DEFAULT)
			m_cardChosen = m_cardHovered

	if (Input.is_action_just_pressed("click")) and m_chipHovered:
		if !m_chipChosen:
			m_chipHovered.custom_minimum_size = Vector2(180,180)
			m_chipChosen = m_chipHovered
		elif m_chipChosen == m_chipHovered:
			m_chipChosen.custom_minimum_size = Vector2(150,150)
			m_chipChosen = null
		elif m_chipChosen != m_chipHovered:
			m_chipHovered.custom_minimum_size = Vector2(180,180)
			m_chipChosen.custom_minimum_size = Vector2(120,120)
			m_chipChosen = m_chipHovered
			
func cardHoveredEnter(_card:Card):
	m_cardHovered = _card
	if _card != m_cardChosen:
		_card.setCardState(Globals.cardState.HOVERED)

func cardHoveredExit(_card:Card):
	m_cardHovered = null
	if _card != m_cardChosen:
		_card.setCardState(Globals.cardState.DEFAULT)

func mouseEnteredChip(_chip:Chip):
	m_chipHovered = _chip
	$CombatUICharacter.mouseEnteredChip(_chip)
	if _chip != m_chipChosen:
		_chip.custom_minimum_size = Vector2(150,150)

func mouseExitedChip(_chip:Chip):
	$CombatUICharacter.mouseExitedChip(_chip)
	m_chipHovered = null
	if _chip != m_chipChosen:
		_chip.custom_minimum_size = Vector2(120,120)

func _on_buy_card_pressed() -> void:
	if $TextureRect/TabContainer.current_tab == 0:
		if GpState.m_currentDollars >= m_cardChosen.m_buyCost:
			GpState.m_cards.append(m_cardChosen.m_name)
			GpState.m_currentDollars -= m_cardChosen.m_buyCost
			m_cardChosen.get_parent().queue_free()
			
	if $TextureRect/TabContainer.current_tab == 1:
		if GpState.m_currentDollars >= m_chipChosen.m_buyCost:
			GpState.getHero().addChip(m_chipChosen)
			GpState.m_currentDollars -= m_chipChosen.m_buyCost
			m_chipChosen.get_parent().get_parent().queue_free()
			m_chipChosen.custom_minimum_size = Vector2(30,30)
			$CombatUICharacter.init(GpState.getHero())

func _on_leave_pressed() -> void:
	MainUI.goToNextLevel()
