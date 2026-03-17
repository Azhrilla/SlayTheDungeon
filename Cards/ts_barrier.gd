extends Card

func _ready():
	m_cardType = Globals.cardType.POWER

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	_hero.addToStatusVariable(Globals.statusType.BARRIER,1)
