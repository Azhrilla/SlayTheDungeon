extends Card

@export var m_damage:int = 5

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		var target = findTargetInSlot(_targets,index)
		if target:
			var isTargetKilled = attackTarget(m_damage,target,_allies)
			var target2 = findTargetInSlot(_targets,index+1)
			if target2:
				var newDmg = 5
				if isTargetKilled:
					newDmg = 10
				attackTarget(newDmg,target2,_allies)
			return
