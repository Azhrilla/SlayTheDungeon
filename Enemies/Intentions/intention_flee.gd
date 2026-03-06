class_name Intention_FleeArmor extends Intention

var m_armor:int = 0

func _init(_armor:int = 0)-> void:
	m_armor = _armor

func findMonsterInSlot(_slot:Globals.target,_allies:Array[Character]) -> Character:
	for target in _allies:
		if target.m_currentPosition == _slot:
			return target
	return null

func updateIntentionStatus(_intentionNode:Control)->void:
	_intentionNode.setStatus(0,Globals.statusType.JUMP)
	
func doWork(_actor:Enemy,_target:Hero,_allies:Array[Character],_level:GameLevel) -> void:
		_actor.addToStatusVariable(Globals.statusType.ARMOR,m_armor)
		if !findMonsterInSlot(Globals.target.ENEMY4,_allies):
			_actor.moveTo(Globals.target.ENEMY4)
		elif !findMonsterInSlot(Globals.target.ENEMY3,_allies):
			_actor.moveTo(Globals.target.ENEMY3)
		elif !findMonsterInSlot(Globals.target.ENEMY2,_allies):
			_actor.moveTo(Globals.target.ENEMY2)
