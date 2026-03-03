extends Enemy
@export var m_maxHealth:int = 30
@export var m_poison:int = 2
@export var m_armor:int = 3
@export var m_baseDmg:int = 3

func _ready() -> void:
	m_maximumHealth = m_maxHealth
	m_intentions=[Intention_Poison.new(m_poison),Intention_SimpleDmg.new(m_baseDmg),Intention_SimpleDmg.new(m_baseDmg+1),Intention_SimpleDmg.new(m_baseDmg+2),Intention_FleeArmor.new(m_armor)]
	m_defaultWeightsIntentions = [1,1,1,0]
	super._ready()
		
func choseIntention():
	if m_currentPosition == Globals.target.ENEMY1 and getMonsters().size() < 4:
		setIntention(m_intentions[4])
		return
		
	var rng = RandomNumberGenerator.new()
	setIntention(m_intentions[rng.rand_weighted(m_defaultWeightsIntentions)])
