class_name Intention_Shield_Bash extends Intention

var m_dmg:int = 0
var m_animName:String = ""
var m_weakCount = 0

func _init(_weakCount:int,_dmg:int = 0,_animName:String = "Attack")-> void:
	m_dmg = _dmg
	m_animName = _animName
	m_weakCount = _weakCount

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_dmg,Globals.statusType.WEAK)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	_target.addToStatusVariable(Globals.statusType.WEAK,m_weakCount)
	attack(_actor,_target,m_dmg)
	_actor.playAnim(m_animName)
