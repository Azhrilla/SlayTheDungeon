extends CanvasLayer


func _ready() -> void:
	$ColorRect.modulate = Color(0,0,0,0)

func goToNextLevel()->void:
	if GpState.m_currentLevel == Globals.m_lvl1:
		GpState.m_currentLevel = Globals.m_lvl2
		TransitionLayer.switchLevel(Globals.m_playLevel)
	elif GpState.m_currentLevel == Globals.m_lvl2:
		GpState.m_currentLevel = Globals.m_lvl3
		TransitionLayer.switchLevel(Globals.m_playLevel)
	else:
		TransitionLayer.switchLevel(Globals.m_victoryLevel)

func switchLevel(_lvlName:String):
	
	var tween = get_tree().create_tween()
	await tween.tween_property($ColorRect,"modulate",Color(0,0,0,1),0.3).finished
	get_tree().change_scene_to_file(_lvlName)
	var tween2 = get_tree().create_tween()
	tween2.tween_property($ColorRect,"modulate",Color(0,0,0,0),0.3)
