extends Control

class_name ObjectBase
var m_targetType = Globals.cardTarget.NONE
signal isObjectToggled

func findTargetInSlot(_targets:Array[Character],_slot:Globals.target) -> Character:
	for target in _targets:
		if target.m_currentPosition == _slot:
			return target
	return null

func isPowerUp():
	return false

func getCost() -> int:
	return 0

func getTargetType() -> Globals.cardTarget:
	return m_targetType

func doWork(_enemies:Array[Character],_hero:Hero,_targetPosition:Globals.target,_card:Card) -> void:
	pass

func _on_texture_button_toggled(toggled_on: bool) -> void:
	isObjectToggled.emit(self,toggled_on)

func setToggle(_value:bool) -> void:
	$TextureButton.button_pressed = _value

func getToggle()->bool:
	return $TextureButton.button_pressed
