extends Control

var m_costRemove = 100
var m_costChip = 100

func _ready() -> void:
	if GpState.m_currentDollars < m_costChip:
		$TextureRect2/ChipButton.disabled = true
	if GpState.m_currentDollars < m_costRemove:
		$TextureRect2/RemoveCardButton.disabled = true

func _on_button_next_pressed() -> void:
	TransitionLayer.goToNextLevel()

func _on_remove_card_button_pressed() -> void:
	GpState.m_currentDollars-=m_costRemove
	TransitionLayer.switchLevel(Globals.m_removeCardLevel)

func _on_chip_button_pressed() -> void:
	GpState.m_currentDollars-=m_costChip
	var newChip = ChipFactory.createChip(Globals.m_basicChipList.pick_random())
	GpState.m_hero.addChip(newChip)
	TransitionLayer.goToNextLevel()
