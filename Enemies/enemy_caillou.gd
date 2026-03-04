extends Enemy

@export var m_baseDmg:int = 4
@export var m_highDmg:int = 6
@export var m_maxHealth:int = 40
@export var m_armorGainedWhenHit:int = 5

func _ready() -> void:
	m_maximumHealth = m_maxHealth
	m_intentions=[Intention_SimpleDmg.new(m_baseDmg),Intention_SimpleDmg.new(m_highDmg)]
	m_defaultWeightsIntentions = [3,2]
	super._ready()

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	super.onDamageTaken(_effectiveDmg,_attacker)
	addToStatusVariable(Globals.statusType.ARMOR,m_armorGainedWhenHit)
	$AnimationPlayer.play("Parry")
	$AnimationPlayer.queue("Idle")
