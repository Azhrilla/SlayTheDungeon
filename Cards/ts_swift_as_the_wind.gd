extends Card
@export var m_addedDmg:int = 5
@export var m_addedDmgUpgrade:int = 5

func _ready():
	super._ready()
	m_cardType = Globals.cardType.POWER
	var cardText = $cardText.text
	$cardText.text = cardText.format({"dmg":str(m_addedDmg)})
	cardText = $textUpgrade.text
	$textUpgrade.text = cardText.format({"dmg":str(m_addedDmgUpgrade)})

func processPowersWhenAttacking(_attack:atkObject):
	if _attack.m_target.m_currentPosition == Globals.target.ENEMY1:
		_attack.m_baseDmg += m_addedDmg 

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	pass
