class_name Intention_SimpleDmg extends Intention

var m_dmg:int = 0
var m_animName:String = ""

func _init(_dmg:int = 0,_animName:String = "Attack")-> void:
	m_dmg = _dmg
	m_animName = _animName

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_dmg,Globals.statusType.DMG)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	attack(_actor,_target,m_dmg)
	_actor.playAnim(m_animName)
