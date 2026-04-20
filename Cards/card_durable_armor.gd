extends Card
@export var m_upgradedArmor:int = 10

func _ready() -> void:
	m_cardType = Globals.cardType.POWER
	var cardText = $textUpgrade.text
	$textUpgrade.text = cardText.format({"value":str(m_upgradedArmor)})
	
func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	_hero.m_armorIsPermanent = true
