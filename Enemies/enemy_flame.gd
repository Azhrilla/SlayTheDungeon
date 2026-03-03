extends Enemy
@export var m_maxHealth:int = 30
@export var m_spike:int = 2
@export var m_highDmg:int = 5
@export var m_baseDmg:int = 3


func _ready() -> void:
	m_maximumHealth = m_maxHealth
	setStatusVariable(Globals.statusType.SPIKE,1)
	m_intentions=[Intention_SimpleDmg.new(m_baseDmg),Intention_SimpleDmg.new(m_highDmg),Intention_Spike.new(m_spike)]
	m_defaultWeightsIntentions = [3,2,1]
	super._ready()

	
