extends ObjectBase

class_name Object_PowerUp

func getCost() -> int:
	return 1

func isPowerUp():
	return true

func _ready() -> void:
	m_targetType = Globals.cardTarget.CARD

func doWork(_enemies:Array[Character],_hero:Hero,_targetPosition:Globals.target,_card:Card) -> void:
	_card.doWorkUpgraded(_enemies,_hero,_targetPosition)
