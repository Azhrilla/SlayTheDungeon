extends Enemy
const MAX_HEALTH:int  = 30 
var ATK_DMG:int = 10


func _ready() -> void:
	m_maximumHealth = MAX_HEALTH
	setStatusVariable(Globals.statusType.SPIKE,1)
	m_intentions = ["Dmg3","Dmg3","Dmg3","Dmg5","Dmg5","Spike+2"]
	super._ready()

func updateIntentionStatus(_str:String):
	super.updateIntentionStatus(_str)
	if _str.contains("Spike+2"):
		$CharUI/UIContainer/Control/Icon_Status.setStatus(2,Globals.statusType.SPIKE)

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
			addToStatusVariable(Globals.statusType.SPIKE,2)
	
