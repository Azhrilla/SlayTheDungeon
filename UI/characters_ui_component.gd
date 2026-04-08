extends Control
class_name CharacterUIComponent

var m_dragMode:Globals.dragMod = Globals.dragMod.NONE
var m_characters:Array[Character] = []
var m_currentTarget:Globals.target = Globals.target.NONE
var m_targetType:Globals.cardTarget = Globals.cardTarget.NONE

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func setCharacters(_chars:Array[Character]) -> void:
	m_characters = _chars

func getPlayerPosition():
	return $PlayerPos.position

func removeCharacter(_chars:Character)->void:
	m_characters.erase(_chars)

func isTargetControlZoneEmpty(_target:Globals.target)->bool:
	for character in m_characters:
		if character.m_currentPosition == _target:
			return false
	return true

func setCurrentTargetType(_targetType:Globals.cardTarget):
	m_targetType = _targetType

func canControlZoneBeTargeted(_target:Globals.target) -> bool:
	match m_targetType:
		Globals.cardTarget.ENEMY:
			return !isTargetControlZoneEmpty(_target)
		Globals.cardTarget.EMPTY:
			return isTargetControlZoneEmpty(_target)
		Globals.cardTarget.ANY:
			return true
		_:
			return false

func setEnteredTargetControlZone(_target:Globals.target)->void:
	if !canControlZoneBeTargeted(_target):
		return
	m_currentTarget = _target

func _on_control_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY1)

func _on_control_2_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY2)

func _on_control_3_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY3)

func _on_control_4_mouse_entered() -> void:
	setEnteredTargetControlZone(Globals.target.ENEMY4)

func onMouseExitTargetControlZone() -> void:
	m_currentTarget = Globals.target.NONE
	
func refreshPositions():
	for character in m_characters:
		if character.m_type == Globals.type.HERO:
			character.position = $PlayerPos.position
		if character.m_type == Globals.type.MONSTER:
			character.position = getMonsterPosition(character.m_currentPosition)

func setDragMode(_dragMod:Globals.dragMod):
	m_dragMode = _dragMod
	$Enemies.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Enemies/MonsterBox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		var controlBox = getControlFromPosition(index)
		if m_dragMode == Globals.dragMod.TARGET:
			controlBox.mouse_filter = Control.MOUSE_FILTER_STOP
		else:
			controlBox.mouse_filter = Control.MOUSE_FILTER_IGNORE

func getControlFromPosition(_pos:Globals.target)->Control:
	var currentBox = $Enemies/MonsterBox/Control
	match _pos:
		Globals.target.ENEMY1:
			currentBox = $Enemies/MonsterBox/Control
		Globals.target.ENEMY2:
			currentBox = $Enemies/MonsterBox/Control2
		Globals.target.ENEMY3:
			currentBox = $Enemies/MonsterBox/Control3
		Globals.target.ENEMY4:
			currentBox = $Enemies/MonsterBox/Control4
		_:
			push_error("Trying to get position of a monster with non valid position")
	return currentBox
	
func addTrap(_trap:TrapBase)->void:
	var controlBox = getControlFromPosition(_trap.m_position)
	controlBox.add_child(_trap)

func getMonsterPosition(_pos:Globals.target)->Vector2:
	var currentBox = getControlFromPosition(_pos)
	return currentBox.global_position + currentBox.custom_minimum_size/2

func showTargetingHelpers():
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		if canControlZoneBeTargeted(index):
			getControlFromPosition(index).get_child(0).get_child(0).visible = true

func hideTargetingHelpers():
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		getControlFromPosition(index).get_child(0).get_child(0).visible = false

func showCharacters():
	for character in m_characters:
		character.visible = true
	
func hideCharacters():
	for character in m_characters:
		character.visible = false
