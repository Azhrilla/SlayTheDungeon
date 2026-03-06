extends Card

@export var m_armor:int = 3

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	_hero.addToStatusVariable(Globals.statusType.ARMOR,m_armor)
