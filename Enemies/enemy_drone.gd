extends Enemy

const MAX_HEALTH:int  = 30 
var m_isKO:bool = false

func _ready() -> void:
	m_currentHealth = MAX_HEALTH
	m_intentions = ["Dmg3","Dmg5"]
	super._ready()
	$AnimationPlayer.play("Idle")

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.startRound(_heroes,_monsters)
	if m_isKO:
		m_isKO = false
		$AnimationPlayer.play_backwards("Death")
		$AnimationPlayer.queue("Idle")

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	super.onDamageTaken(_effectiveDmg,_attacker)
	m_currentIntention = "N/A"
	$CharUI/UIContainer/Control/Icon_Status.setStatus(0,Globals.statusType.INTERRO)
	if !m_isKO:
		$AnimationPlayer.play("Death")
	m_isKO = true

func attack(_heroes:Array[Character]) -> void:
	var target = _heroes.pick_random()
	match m_currentIntention:
		"Dmg3":
			target.takeDmg(3,self)
			playAttackAnim()
		"Dmg5":
			target.takeDmg(5,self)
			playAttackAnim()
