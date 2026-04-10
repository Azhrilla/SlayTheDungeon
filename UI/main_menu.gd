extends Control



var timerest = 0

func _on_start_game_button_pressed() -> void:
	GpState.m_currentBloc = Act1_Bloc1.new()
	GpState.resetGPState()
	MainUI.goToNextLevel()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
