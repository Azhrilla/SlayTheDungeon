extends Card

func _ready():
	m_cardType = Globals.cardType.POWER

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	_allies[0].addToStatusVariable(Globals.statusType.BARRIER,1)
