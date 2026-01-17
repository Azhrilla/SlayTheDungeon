extends Card

@export var m_damage:int = 5

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	for target in _targets:
		attackTarget(m_damage,target,_allies)
