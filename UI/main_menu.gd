extends Control

const heroScene:PackedScene = preload("res://Game/hero.tscn")

func _on_start_game_button_pressed() -> void:
	
	GpState.m_hero = heroScene.instantiate()
	TransitionLayer.goToNextLevel()
	var chip = chip_healtPack.new()
	chip.m_hero = GpState.m_hero
	GpState.m_hero.m_chips.append(chip)
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
