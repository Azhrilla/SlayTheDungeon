extends Enemy
var m_isKO:bool = false
const MAX_HEALTH:int  = 30 
var m_shieldWasUp = false

func _ready() -> void:
	m_maximumHealth = MAX_HEALTH
	m_intentions=[Intention_SimpleDmg.new(3),Intention_SimpleDmg.new(5),Intention_BarrierAlly.new(),Intention_Stunned.new()]
	m_defaultWeightsIntentions = [2,2,1,0]
	super._ready()
	$AnimationPlayer.play("Idle")

func _process(_delta: float) -> void:
	super._process(_delta)
	if getStatusVariable(Globals.statusType.BARRIER) > 0 and !m_shieldWasUp:
		$ShieldComponent.startShield()
		m_shieldWasUp = true
	elif getStatusVariable(Globals.statusType.BARRIER) == 0 and m_shieldWasUp:
		$ShieldComponent.stopShield()
		m_shieldWasUp = false


func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.startRound(_heroes,_monsters)
	if m_isKO:
		m_isKO = false
		$AnimationPlayer.play_backwards("Death")
		$AnimationPlayer.queue("Idle")

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	super.onDamageTaken(_effectiveDmg,_attacker)
	setIntention(m_intentions[3])
	if !m_isKO:
		$AnimationPlayer.play("Death")
	m_isKO = true
