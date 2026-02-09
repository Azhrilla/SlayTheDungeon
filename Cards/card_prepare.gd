extends Card

@export var m_armor:int = 3

func _ready() -> void:
	var cardText = $cardText.text
	$cardText.text = cardText.format({"armor":str(m_armor)})

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	m_player.drawCard()
	_allies.pick_random().addToStatusVariable(Globals.statusType.ARMOR,m_armor)
