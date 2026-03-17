extends Card

@export var m_armor:int = 3

func _ready() -> void:
	var cardText = $cardText.text
	$cardText.text = cardText.format({"armor":str(m_armor)})
	super._ready()

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	m_player.drawCard()
	_hero.addToStatusVariable(Globals.statusType.ARMOR,m_armor)
