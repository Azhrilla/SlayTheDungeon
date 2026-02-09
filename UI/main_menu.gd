extends Control

const heroScene:PackedScene = preload("res://Game/hero.tscn")

var timerest = 0

func _ready() -> void:
	GpState.m_hero = heroScene.instantiate()
	GpState.m_currentBloc = Act1_Bloc1.new()
	GpState.m_currentDollars = 100

func _on_start_game_button_pressed() -> void:
	MainUI.goToNextLevel()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
