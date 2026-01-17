extends Control

func _on_start_game_button_pressed() -> void:
	TransitionLayer.switchLevel(Globals.nextLevel)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
