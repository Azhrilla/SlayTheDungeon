extends Card

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	if findTargetInSlot(_targets,Globals.target.ENEMY1):
		return
		
	for index in range(Globals.target.ENEMY2,Globals.target.ENEMY4+1):
		var target = findTargetInSlot(_targets,index)
		if target:
			target.decreasePosition()
			return
