extends Card
const m_addedDmg:int = 5

func _ready():
	m_cardType = Globals.cardType.POWER

func processPowersWhenAttacking(_attack:atkObject):
	if _attack.m_target.m_currentPosition == Globals.target.ENEMY1:
		_attack.m_baseDmg += m_addedDmg 
		
func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	pass
