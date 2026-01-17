extends Card

@export var m_damage:int = 5

func needTarget() -> bool:
	return true

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	if _targetPosition == Globals.target.NONE:
		push_error("More than on target for attack_one")
	
	var target = findTargetInSlot(_targets,_targetPosition)
	if target:
		attackTarget(m_damage,target,_allies)
