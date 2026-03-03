extends Enemy
const MAX_HEALTH:int  = 40 
var ATK_DMG:int = 10
@export var m_baseDmg:int = 4
@export var m_highDmg:int = 6

func _ready() -> void:
	m_maximumHealth = MAX_HEALTH
	m_intentions=[Intention_SimpleDmg.new(m_baseDmg),Intention_SimpleDmg.new(m_highDmg)]
	m_defaultWeightsIntentions = [3,2]
	super._ready()

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	super.onDamageTaken(_effectiveDmg,_attacker)
	addToStatusVariable(Globals.statusType.ARMOR,5)
	$AnimationPlayer.play("Parry")
	$AnimationPlayer.queue("Idle")
