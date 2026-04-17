extends Enemy
@export var m_maxHealth:int = 30
@export var m_poison:int = 2
@export var m_armor:int = 3
@export var m_baseDmg:int = 3

func _ready() -> void:
	m_maximumHealth = m_maxHealth
	m_intentions=[Intention_Poison.new(m_poison),Intention_SimpleDmg.new(m_baseDmg),Intention_Charge.new(m_baseDmg+2),Intention_SimpleDmg.new(m_baseDmg+1),Intention_FleeArmor.new(m_armor)]
	m_defaultWeightsIntentions = [1,1,1,0]
	super._ready()
		
func choseIntention():
	var rng = m_rngGenerator.randf()
	# if cac => flee or chomp (base dmg or base dmg +1)
	if m_currentPosition == Globals.target.ENEMY1 or m_currentPosition == Globals.target.ENEMY2:
		if getMonsters().size() < 4 && rng < 0.5:
			setIntention(m_intentions[4])
		else:
			setIntention(m_intentions[m_rngGenerator.rand_weighted([0,1,0,1,0])])
	# if range : charge or poison
	else:
		if (!findMonsterInSlot(Globals.target.ENEMY1) or !findMonsterInSlot(Globals.target.ENEMY2)) && rng < 0.33:
			setIntention(m_intentions[2])
		else:
			setIntention(m_intentions[0])
