extends Control

func _on_button_next_pressed() -> void:
	TransitionLayer.goToNextLevel()

func _on_remove_card_button_pressed() -> void:
	TransitionLayer.switchLevel(Globals.m_removeCardLevel)

func _on_chip_button_pressed() -> void:
	var newChip = ChipFactory.createChip(Globals.m_basicChipList.pick_random())
	GpState.m_hero.addChip(newChip)
	TransitionLayer.goToNextLevel()
