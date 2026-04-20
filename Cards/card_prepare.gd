extends Card

@export var m_armor:int = 3
@export var m_upgradedArmor:int = 10

func _ready() -> void:
	var cardText = $cardText.text
	$cardText.text = cardText.format({"armor":str(m_armor)})
	cardText = $textUpgrade.text
	$textUpgrade.text = cardText.format({"value":str(m_upgradedArmor)})
	super._ready()

func doWorkUpgraded(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	m_player.drawCard()
	_hero.addToStatusVariable(Globals.statusType.ARMOR,m_upgradedArmor)

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	m_player.drawCard()
	_hero.addToStatusVariable(Globals.statusType.ARMOR,m_armor)
