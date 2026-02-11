extends Enemy
@export var m_maxHealth:int = 30
@export var m_poison:int = 2
@export var m_armor:int = 3
@export var m_baseDmg:int = 3

func _ready() -> void:
	m_maximumHealth = m_maxHealth
	m_intentions = ["Dmg3","Dmg4","Dmg5","Poison"]
	super._ready()

func updateIntentionStatus(_str:String):
	super.updateIntentionStatus(_str)
	if _str.contains("Poison"):
		$CharUI/UIContainer/Control/Icon_Status.setStatus(m_poison,Globals.statusType.POISON)
	if _str.contains("Flee"):
		$CharUI/UIContainer/Control/Icon_Status.setStatus(0,Globals.statusType.JUMP)
		
func choseIntention():
	if m_currentPosition == Globals.target.ENEMY1 and getMonsters().size() < 4:
		m_currentIntention = "Flee"
		updateIntentionStatus(m_currentIntention)
		return

	
	m_currentIntention = m_intentions.pick_random()
	updateIntentionStatus(m_currentIntention)


func doWork(_heroes:Array[Character],_allies:Array[Character]) -> void:
	if m_currentIntention.contains("Dmg"):
		var strIntention = m_currentIntention
		strIntention.remove_chars("Dmg")
		var target = _heroes.pick_random()
		target.takeDmg(strIntention.to_int(),self)
	
	if m_currentIntention.contains("Poison"):
		var target = _heroes.pick_random()
		target.addToStatusVariable(Globals.statusType.POISON,m_poison)
	
	if m_currentIntention.contains("Flee"):
		addToStatusVariable(Globals.statusType.ARMOR,m_armor)
		if !findMonsterInSlot(Globals.target.ENEMY4):
			moveTo(Globals.target.ENEMY4)
		elif !findMonsterInSlot(Globals.target.ENEMY3):
			moveTo(Globals.target.ENEMY3)
		elif !findMonsterInSlot(Globals.target.ENEMY2):
			moveTo(Globals.target.ENEMY2)
