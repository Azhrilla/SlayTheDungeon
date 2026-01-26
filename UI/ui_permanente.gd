extends CanvasLayer

func _process(_delta: float) -> void:
	#print (get_viewport().gui_get_hovered_control())
	pass
	
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
