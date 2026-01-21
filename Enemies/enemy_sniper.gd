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

func updateIntentionText():
	match m_currentIntention:
		"Fire at will":
			$Intention.text = "Intent: dmg 30"
		"Aim":
			$Intention.text = "Intent: "+m_currentIntention
		"JumpShot":
			$Intention.text = "Intent: jump + dmg{dmg}".format({"dmg": str(m_baseDmg*getMult())})
		"Fire":
			$Intention.text = "Intent: dmg{dmg}".format({"dmg": str(2*m_baseDmg*getMult())})
		"None":
			$Intention.text = "N/A"

func choseIntention():
	if m_isAiming:
		m_currentIntention = "Fire at will"
	elif m_currentPosition == Globals.target.ENEMY4:
		m_currentIntention = "Aim"
	else:
		m_currentIntention = m_intentions.pick_random()
		
	updateIntentionText()
	
	

func attack(_heroes:Array[Character]) -> void:
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
