class_name Intention

func attack(_actor:Enemy,_target:Hero,_atkValue:int):
	var realDmg = _actor.getStatusVariable(Globals.statusType.STR) + _atkValue
	_target.takeDmg(realDmg,_actor)

func updateIntentionStatus(_intentionNode:Control)->void:
	pass
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	pass
