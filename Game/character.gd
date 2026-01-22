extends Node

class_name Character
var m_startingHealth = 40
var m_currentHealth = 0
var m_currentArmor = 0
var m_type = Globals.type.NONE
var m_currentPosition = 0
var m_spikeDmg:int = 0
var m_strength:int = 0


signal OnDeath
signal mouseOver(_char:Character)
var iconStatusScene:PackedScene = preload("res://UI/Icons/icon_status.tscn")


func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	m_currentArmor = 0
	
func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	pass

func _ready() -> void:
	$CharUI/UIContainer/HealthBar.max_value = m_currentHealth

func getStatusCount() -> int:
	var statusCount = 0
	if m_currentArmor > 0:
		statusCount+=1
	if m_spikeDmg > 0:
		statusCount+=1
		
	if m_strength > 0:
		statusCount+=1
	return statusCount

func setArmor(indexStatusInput:int) -> int:
	if m_currentArmor == 0:
		return indexStatusInput
	var statusIcon = $CharUI/UIContainer/StatusContainer.get_child(indexStatusInput)
	statusIcon.setStatus(m_currentArmor,Globals.statusType.ARMOR)
	return indexStatusInput + 1

func setStr(indexStatusInput:int) -> int:
	if m_strength == 0:
		return indexStatusInput
	var statusIcon = $CharUI/UIContainer/StatusContainer.get_child(indexStatusInput)
	statusIcon.setStatus(m_strength,Globals.statusType.STR)
	return indexStatusInput + 1

func setSpike(indexStatusInput:int) -> int:
	if m_spikeDmg == 0:
		return indexStatusInput
	var statusIcon = $CharUI/UIContainer/StatusContainer.get_child(indexStatusInput)
	statusIcon.setStatus(m_spikeDmg,Globals.statusType.SPIKE)
	return indexStatusInput + 1

func updateStatusGUI():
	var statusCount = getStatusCount()
	while $CharUI/UIContainer/StatusContainer.get_child_count() > statusCount:
		$CharUI/UIContainer/StatusContainer.remove_child($CharUI/UIContainer/StatusContainer.get_child(0))
	while $CharUI/UIContainer/StatusContainer.get_child_count() < statusCount:
		$CharUI/UIContainer/StatusContainer.add_child(iconStatusScene.instantiate())
	
	var statusIndex = 0
	statusIndex = setArmor(statusIndex)
	statusIndex = setSpike(statusIndex)
	statusIndex = setStr(statusIndex)
	
func _process(_delta: float) -> void:
	updateStatusGUI()
	$CharUI/UIContainer/HealthBar.value = m_currentHealth
	$CharUI/UIContainer/HealthBar/HealthValue.text = "PVs:{0}".format([m_currentHealth])

func useArmorAndGetDmg(_dmg:int) -> int:
	var absorbedDmg = min(m_currentArmor,_dmg)
	var effectiveDmg:int = _dmg - absorbedDmg
	m_currentArmor -= absorbedDmg
	return effectiveDmg

func increasePosition() -> void:
	if m_currentPosition != Globals.target.ENEMY4:
		moveTo(m_currentPosition + 1)

func decreasePosition() -> void:
	if m_currentPosition != Globals.target.ENEMY1:
		moveTo(m_currentPosition - 1)

func moveTo(_target:Globals.target)->void:
	m_currentPosition = _target

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	_attacker.takeDmg(m_spikeDmg,self)


func heal(_value:int)->void:
	m_currentHealth += _value
	if m_currentHealth > m_startingHealth:
		m_currentHealth = m_startingHealth

func takeDmg(_dmg:int,_attacker:Character,_isAttackFirstTrigger:bool = true):
	var effectiveDmg:int =useArmorAndGetDmg(_dmg)
	
	if effectiveDmg == 0:
		return
		
	if _isAttackFirstTrigger:
		onDamageTaken(effectiveDmg,_attacker)
		
	m_currentHealth -= effectiveDmg
	
	if m_currentHealth<=0:
		OnDeath.emit(self)
	
func addArmor(_armor:int):
	m_currentArmor+=_armor

func _on_mouse_entered() -> void:
	mouseOver.emit(self)
