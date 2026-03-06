extends ObjectBase

class_name Object_TechnoCanon

func getCost() -> int:
	return 1

func needTarget() -> bool:
	return true

func doWork(_enemies:Array[Character],_hero:Hero,_targetPosition:Globals.target) -> void:
	if _targetPosition == Globals.target.NONE:
		push_error("More than on target for attack_one")
	
	var target = findTargetInSlot(_enemies,_targetPosition)
	if target:
		target.takeDmg(5,_hero)
