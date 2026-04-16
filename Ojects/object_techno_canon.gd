extends ObjectBase

class_name Object_TechnoCanon

func getCost() -> int:
	return 1

func _ready() -> void:
	m_targetType = Globals.cardTarget.ENEMY

func doWork(_enemies:Array[Character],_hero:Hero,_targetPosition:Globals.target,_card:Card) -> void:
	if _targetPosition == Globals.target.NONE:
		push_error("More than on target for attack_one")
	
	var target = findTargetInSlot(_enemies,_targetPosition)
	if target:
		target.takeDmg(5,_hero)
