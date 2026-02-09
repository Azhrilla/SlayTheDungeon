extends Enemy

const MAX_HEALTH:int  = 30 
var m_isAiming:bool = false
const m_baseDmg = 3

func _ready() -> void:
	m_currentHealth = MAX_HEALTH
	m_intentions = ["JumpShot","Fire"]
	m_currentPosition = Globals.target.ENEMY3
	super._ready()

func getMult() -> int:
	match m_currentPosition:
		Globals.target.ENEMY4:
			return 4
		Globals.target.ENEMY3:
			return 3
		Globals.target.ENEMY2:
			return 2
		_:
			return 1

func moveTo(_target:Globals.target):
	super.moveTo(_target)
	if m_isAiming:
		m_currentIntention = "None"
		m_isAiming = false
	updateIntentionText()

func updateIntentionStatus(_str:String):
	super.updateIntentionStatus(_str)
	if _str.is_empty():
		$CharUI/UIContainer/Control/Icon_Status.setStatus(0,Globals.statusType.INTERRO)
	if _str.contains("Jump"):
		_str.remove_chars("Jump")
		$CharUI/UIContainer/Control/Icon_Status.setStatus(_str.to_int(),Globals.statusType.JUMP)
	
	
func updateIntentionText():
	match m_currentIntention:
		"Fire at will":
			updateIntentionStatus("Dmg30")
		"Aim":
			updateIntentionStatus("Dmg0")
		"JumpShot":
			var newStr	= "Jump{dmg}".format({"dmg": str(m_baseDmg*getMult())})
			updateIntentionStatus(newStr)
		"Fire":
			var newStr	= "Dmg{dmg}".format({"dmg": str(2*m_baseDmg*getMult())})
			updateIntentionStatus(newStr)
		_:
			updateIntentionStatus("")

func choseIntention():
	if m_isAiming:
		m_currentIntention = "Fire at will"
	elif m_currentPosition == Globals.target.ENEMY4:
		m_currentIntention = "Aim"
	else:
		m_currentIntention = m_intentions.pick_random()
	updateIntentionText()

func doWork(_heroes:Array[Character],_allies:Array[Character]) -> void:
	var target = _heroes.pick_random()
	match m_currentIntention:
		"Aim":
			m_isAiming = true
		"JumpShot":
			increasePosition()
			target.takeDmg(m_baseDmg*getMult(),self)
		"Fire":	
			target.takeDmg(2*m_baseDmg*getMult(),self)
		"Fire at will":
			m_isAiming = false
			target.takeDmg(30,self)
