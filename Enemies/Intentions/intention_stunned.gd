class_name Intention_Stunned extends Intention

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(0,Globals.statusType.INTERRO)
