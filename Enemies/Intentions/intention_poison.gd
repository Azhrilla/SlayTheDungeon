class_name Intention_Poison extends Intention

var m_poisonValue:int = 0

func _init(_poison:int = 0)-> void:
	m_poisonValue = _poison

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_poisonValue,Globals.statusType.POISON)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	_target.addToStatusVariable(Globals.statusType.POISON,m_poisonValue)
