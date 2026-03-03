class_name Intention_BarrierAlly extends Intention


func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(0,Globals.statusType.BARRIER)
	
func doWork(_actor:Character,_target:Character,_allies:Array[Character],_level:GameLevel) -> void:
	var ally = _allies.pick_random()
	ally.addToStatusVariable(Globals.statusType.BARRIER,1)
