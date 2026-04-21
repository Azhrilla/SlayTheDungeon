class_name Intention_Protect extends Intention

var m_shieldAmount:int = 0

func _init(_str:int = 0)-> void:
	m_shieldAmount = _str

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_shieldAmount,Globals.statusType.ARMOR)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	for ally in _allies:
		if ally != _actor:
			ally.addToStatusVariable(Globals.statusType.ARMOR,m_shieldAmount)
