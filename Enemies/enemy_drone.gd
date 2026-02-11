extends Enemy
var m_isKO:bool = false
const MAX_HEALTH:int  = 30 
var m_shieldWasUp = false

func _ready() -> void:
	m_maximumHealth = MAX_HEALTH
	m_intentions = ["Dmg3","Dmg3","Dmg5","Dmg5","Barrier"]
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

func updateIntentionStatus(_str:String):
	super.updateIntentionStatus(_str)
	if _str.contains("Barrier"):
		$CharUI/UIContainer/Control/Icon_Status.setStatus(0,Globals.statusType.BARRIER)

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

func doWork(_heroes:Array[Character],_allies:Array[Character]) -> void:
	var target = _heroes.pick_random()
	match m_currentIntention:
		"Dmg3":
			target.takeDmg(3,self)
			playAttackAnim()
		"Dmg5":
			target.takeDmg(5,self)
			playAttackAnim()
		"Barrier":
			var ally = _allies.pick_random()
			ally.addToStatusVariable(Globals.statusType.BARRIER,1)
