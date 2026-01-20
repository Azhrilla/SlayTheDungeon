extends Control

const heroScene:PackedScene = preload("res://Game/hero.tscn")

func _on_start_game_button_pressed() -> void:
	GpState.m_hero = heroScene.instantiate()
	TransitionLayer.switchLevel(Globals.m_playLevel)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
