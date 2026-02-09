extends Card

func _ready() -> void:
	m_cardType = Globals.cardType.POWER
func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	for ally:Character in _allies :
		ally.m_armorIsPermanent = true
