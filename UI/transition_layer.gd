extends CanvasLayer


func _ready() -> void:
	$ColorRect.modulate = Color(0,0,0,0)

func goToNextLevel()->void:
	if GpState.m_currentLevel.m_goToLoot:
		TransitionLayer.switchLevel(Globals.m_lootLevel)
	elif GpState.m_currentLevel.m_nextLevel:
		GpState.m_currentLevel = GpState.m_currentLevel.m_nextLevel
		TransitionLayer.switchLevel(GpState.m_currentLevel.m_lvlFile)

func switchLevel(_lvlName:String):
	print ("Go to level {str}".format({"str":_lvlName}))
	var tween = get_tree().create_tween()
	await tween.tween_property($ColorRect,"modulate",Color(0,0,0,1),0.3).finished
	get_tree().change_scene_to_file(_lvlName)
	var tween2 = get_tree().create_tween()
	tween2.tween_property($ColorRect,"modulate",Color(0,0,0,0),0.3)
	
