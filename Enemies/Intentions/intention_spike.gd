class_name Intention_Spike extends Intention

var m_spikeAmount:int = 0

func _init(_spike:int = 0)-> void:
	m_spikeAmount = _spike

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_spikeAmount,Globals.statusType.SPIKE)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	_actor.addToStatusVariable(Globals.statusType.SPIKE,m_spikeAmount)
