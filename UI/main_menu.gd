extends Control

const heroScene:PackedScene = preload("res://Game/hero.tscn")

var timerest = 0

func _on_start_game_button_pressed() -> void:
	GpState.resetGPState()
	GpState.m_hero = heroScene.instantiate()
	GpState.m_currentBloc = Act1_Bloc1.new()
	MainUI.goToNextLevel()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
