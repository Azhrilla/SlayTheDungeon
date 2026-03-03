class_name Intention_DroneSpawn extends Intention


func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(0,Globals.statusType.INTERRO)
	
func doWork(_actor:Character,_target:Character,_allies:Array[Character],_level:GameLevel) -> void:
	var slot = Globals.target.ENEMY4
	while _level.findTargetInSlot(slot) != null:
		slot = (slot as int - 1) as Globals.target
	_level.createEnemy("Drone",slot)
