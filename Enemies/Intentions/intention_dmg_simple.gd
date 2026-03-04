class_name Intention_SimpleDmg extends Intention

var m_dmg:int = 0
var m_animName:String = ""

func _init(_dmg:int = 0,_animName:String = "Attack")-> void:
	m_dmg = _dmg
	m_animName = _animName

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_dmg,Globals.statusType.DMG)
	
func doWork(_actor:Character,_target:Character,_allies:Array[Character],_level:GameLevel) -> void:
	_target.takeDmg(m_dmg,_actor)
	_actor.playAnim(m_animName)
