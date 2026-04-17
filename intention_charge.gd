class_name Intention_Charge extends Intention

var m_dmg:int = 0
var m_animName:String = ""

func _init(_dmg:int = 0,_animName:String = "Attack")-> void:
	m_dmg = _dmg
	m_animName = _animName

func findMonsterInSlot(_slot:Globals.target,_allies:Array[Character]) -> Character:
	for target in _allies:
		if target.m_currentPosition == _slot:
			return target
	return null

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(m_dmg,Globals.statusType.JUMP)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
	for position in range (Globals.target.ENEMY1,Globals.target.MAX):
		print (position)
		if !findMonsterInSlot(position,_allies):
			_actor.moveTo(position)
			break
	_target.takeDmg(m_dmg,_actor)
	_actor.playAnim(m_animName)
