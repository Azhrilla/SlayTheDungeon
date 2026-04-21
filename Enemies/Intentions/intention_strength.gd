class_name Intention_Strength extends Intention

var m_strAmount:int = 0

func _init(_str:int = 0)-> void:
	m_strAmount = _str

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_strAmount,Globals.statusType.STR)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	_actor.addToStatusVariable(Globals.statusType.STR,m_strAmount)
