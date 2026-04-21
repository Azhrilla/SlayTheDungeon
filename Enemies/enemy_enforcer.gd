extends Enemy
@export var m_maxHealth:int = 30
@export var m_shootDmg:int = 5
@export var m_bashDmg:int = 3
@export var m_armorProtect:int = 10
@export var m_strengthGain:int = 1
@export var m_weakApplied:int = 1


func _ready() -> void:
	m_maximumHealth = m_maxHealth
	m_intentions=[Intention_SimpleDmg.new(m_shootDmg),Intention_Protect.new(m_armorProtect),Intention_Shield_Bash.new(m_weakApplied,m_bashDmg),Intention_Strength.new(m_strengthGain)]
	super._ready()

func choseIntention():
	var isFirst = true
	for index in range (Globals.target.ENEMY1, m_currentPosition):
		if findMonsterInSlot(index):
			isFirst = false
			break
	
	# if cac => flee or chomp (base dmg or base dmg +1)
	if isFirst:
			setIntention(m_intentions[m_rngGenerator.rand_weighted([0,1,1,0])])
	# if range : charge or poison
	else:
		setIntention(m_intentions[m_rngGenerator.rand_weighted([1,0,0,1])])
