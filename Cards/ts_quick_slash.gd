extends Card

@export var m_damage:int = 10

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	var target = findTargetInSlot(_targets,Globals.target.ENEMY1)
	if (target):
		attackTarget(m_damage,target,_allies)
