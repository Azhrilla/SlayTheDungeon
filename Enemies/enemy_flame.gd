extends Enemy
const MAX_HEALTH:int  = 30 
var ATK_DMG:int = 10


func _ready() -> void:
	m_currentHealth = MAX_HEALTH
	m_spikeDmg = 1
	m_intentions = ["Dmg3","Dmg3","Dmg3","Dmg5","Dmg5","Spike+2"]
	super._ready()
	
func attack(_heroes:Array[Character]) -> void:
	match m_currentIntention:
		"Dmg3":
			ATK_DMG = 3
			var target = _heroes.pick_random()
			target.takeDmg(ATK_DMG,self)
		"Dmg5":
			ATK_DMG = 5
			var target = _heroes.pick_random()
			target.takeDmg(ATK_DMG,self)
		"Spike+2":
			m_spikeDmg +=2
	
