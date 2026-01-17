extends Card

@export var m_armor:int = 3

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	var target = _allies.pick_random()
	target.addArmor(m_armor)
