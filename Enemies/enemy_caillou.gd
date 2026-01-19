extends Enemy
const MAX_HEALTH:int  = 30 
var ATK_DMG:int = 10


func _ready() -> void:
	m_currentHealth = MAX_HEALTH
	m_intentions = ["Dmg4","Dmg4","Dmg4","Dmg6","Dmg6"]
	super._ready()

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	super.onDamageTaken(_effectiveDmg,_attacker)
	m_currentArmor += 5

func attack(_heroes:Array[Character]) -> void:
	match m_currentIntention:
		"Dmg4":
			ATK_DMG = 4
			var target = _heroes.pick_random()
			target.takeDmg(ATK_DMG,self)
		"Dmg6":
			ATK_DMG = 6
			var target = _heroes.pick_random()
			target.takeDmg(ATK_DMG,self)
