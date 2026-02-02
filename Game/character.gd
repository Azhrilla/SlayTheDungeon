extends Node

class_name Character

#Nodes
@onready var m_statusContainer = $CharUI/UIContainer/StatusContainer
@onready var m_healthBar = $CharUI/UIContainer/HealthBar
@onready var m_healthValue = $CharUI/UIContainer/HealthBar/HealthValue

#Scenes
const  iconStatusScene:PackedScene = preload("res://UI/Icons/icon_status.tscn")

#Signals
signal OnDeath

#Attributes
var m_maximumHealth = 40
var m_currentHealth = 0
var m_type = Globals.type.NONE
var m_currentPosition = Globals.target.NONE
var m_statusVariables = {
	Globals.statusType.SPIKE : 0,
	Globals.statusType.STR : 0,
	Globals.statusType.ARMOR : 0,
	Globals.statusType.BARRIER : 0
}

#Base Functions
func _ready() -> void:
	m_healthBar.max_value = m_maximumHealth
	m_currentHealth = m_maximumHealth

func _process(_delta: float) -> void:
	m_healthBar.value = m_currentHealth
	m_healthValue.text = "PVs:{0}".format([m_currentHealth])

#GamePlay Functions
func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	setStatusVariable(Globals.statusType.ARMOR,0)

func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	pass

func useArmorAndGetDmg(_dmg:int) -> int:
	var absorbedDmg = min(m_statusVariables[Globals.statusType.ARMOR],_dmg)
	var effectiveDmg:int = _dmg - absorbedDmg
	m_statusVariables[Globals.statusType.ARMOR] -= absorbedDmg
	return effectiveDmg

func moveTo(_target:Globals.target)->void:
	m_currentPosition = _target

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	_attacker.takeDmg(m_statusVariables[Globals.statusType.SPIKE],self,false)

func heal(_value:int)->void:
	m_currentHealth += _value
	if m_currentHealth > m_maximumHealth:
		m_currentHealth = m_maximumHealth

func takeDmg(_dmg:int,_attacker:Character,_isAttackFirstTrigger:bool = true):
	var effectiveDmg:int = useArmorAndGetDmg(_dmg)
	if effectiveDmg == 0:
		return		
		
	if getStatusVariable(Globals.statusType.BARRIER) > 0:
		addToStatusVariable(Globals.statusType.BARRIER,-1)
		return
		
	if _isAttackFirstTrigger:
		onDamageTaken(effectiveDmg,_attacker)	
		
	m_currentHealth -= effectiveDmg
	if m_currentHealth<=0:
		OnDeath.emit(self)

func getStatusVariable(_status:Globals.statusType) -> int:
	return m_statusVariables[_status]

func setStatusVariable(_status:Globals.statusType,_value:int)->void:
	m_statusVariables[_status]=_value
	updateStatusGUI()

func addToStatusVariable(_status:Globals.statusType,_value:int)->void:
	var newValue = m_statusVariables[_status]+_value
	setStatusVariable(_status,newValue)

#UI Functions
func getStatusCount() -> int:
	var statusCount = 0
	for value in m_statusVariables.values():
		if value > 0:
			statusCount +=1
	return statusCount

func updateStatusGUI():
	var statusCount = getStatusCount()
	while m_statusContainer.get_child_count() > statusCount:
		m_statusContainer.remove_child(m_statusContainer.get_child(0))
	while m_statusContainer.get_child_count() < statusCount:
		m_statusContainer.add_child(iconStatusScene.instantiate())
	
	var statusIndex = 0
	for status in m_statusVariables.keys():
		if m_statusVariables[status] == 0:
			continue
		var statusIcon = m_statusContainer.get_child(statusIndex)
		statusIcon.setStatus(m_statusVariables[status],status)
