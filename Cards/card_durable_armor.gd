extends Card

func _ready() -> void:
	m_cardType = Globals.cardType.POWER

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	_hero.m_armorIsPermanent = true
