extends CanvasLayer

@onready var m_filterForLevelTransition = $FilterForLevelTransition

func _process(_delta: float) -> void:
	#print (get_viewport().gui_get_hovered_control())
	pass

func _ready() -> void:
	m_filterForLevelTransition.visible = true
	m_filterForLevelTransition.modulate = Color(0,0,0,0)
	m_filterForLevelTransition.mouse_filter = Control.MOUSE_FILTER_IGNORE

func addChip(_chip:Chip):
	_chip.mouseEntered.connect(mouseEnteredChip)
	_chip.mouseExited.connect(mouseExitedChip)
	$Control/TextureRect/HBoxContainer.add_child(_chip)

func setDollars(_value:int)->void:
	$Control/TextureRect/HBoxContainer/Dollars.text = str(_value)

func mouseEnteredChip(_chip:Chip):
	$ChipInfo.visible = true
	$ChipInfo/ChipInfoText.text = _chip.getInfoText()

func mouseExitedChip(_chip:Chip):
	$ChipInfo.visible = false

func goToNextLevel()->void:
		switchLevel(GpState.m_currentBloc.getNextLevel())


func switchLevel(_lvlName:String):
	print ("Go to level {str}".format({"str":_lvlName}))
	var tween = get_tree().create_tween()
	await tween.tween_property(m_filterForLevelTransition,"modulate",Color(0,0,0,1),0.3).finished
	get_tree().change_scene_to_file(_lvlName)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(m_filterForLevelTransition,"modulate",Color(0,0,0,0),0.3)
