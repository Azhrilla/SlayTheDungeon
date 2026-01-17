extends Card

@export var m_damage:int = 10

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	var target = _targets.pick_random()
	if target:
		attackTarget(m_damage,target,_allies)
