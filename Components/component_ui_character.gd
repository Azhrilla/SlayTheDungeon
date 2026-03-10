extends Control
class_name ComponentUICharacter
@onready var m_healthBar = $UIContainer/HealthBar
@onready var m_healthValue = $UIContainer/HealthBar/HealthValue
@onready var m_statusContainer = $UIContainer/StatusContainer

#Scenes
const  iconStatusScene:PackedScene = preload("res://UI/Icons/icon_status.tscn")

func init(_char:Character):
	m_healthBar.value = _char.m_currentHealth
	m_healthBar.max_value = _char.m_maximumHealth
	m_healthValue.text = "PVs:{current}/{max}".format({"current":str(_char.m_currentHealth),"max":str(_char.m_maximumHealth)})
	_char.onLifeChanged.connect(onLifeChanged)
	_char.onStatusChanged.connect(onStatusChanged)

func onLifeChanged(_char:Character):
	m_healthBar.value = _char.m_currentHealth
	m_healthValue.text = "PVs:{current}/{max}".format({"current":str(_char.m_currentHealth),"max":str(_char.m_maximumHealth)})
	
func onStatusChanged(_char:Character):
	updateStatusGUI(_char)

#UI Functions
func getStatusCount(_char:Character) -> int:
	var statusCount = 0
	for value in _char.m_statusVariables.values():
		if value > 0:
			statusCount +=1
	return statusCount

func updateStatusGUI(_char:Character):
	var statusCount = getStatusCount(_char)
	while m_statusContainer.get_child_count() > statusCount:
		m_statusContainer.remove_child(m_statusContainer.get_child(0))
	while m_statusContainer.get_child_count() < statusCount:
		m_statusContainer.add_child(iconStatusScene.instantiate())
	
	var statusIndex = 0
	for status in _char.m_statusVariables.keys():
		if _char.m_statusVariables[status] == 0:
			continue
		var statusIcon = m_statusContainer.get_child(statusIndex)
		statusIcon.setStatus(_char.m_statusVariables[status],status)
		statusIndex+=1
