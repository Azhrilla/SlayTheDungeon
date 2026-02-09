extends Enemy

@export var MAX_HEALTH:int  = 100 
@export var m_punch:int = 10
@export var m_whip:int = 8
@export var m_shoot:int = 8
var m_currentRNG = 0

func _ready() -> void:
	m_maximumHealth = MAX_HEALTH
	m_currentPosition = Globals.target.ENEMY2
	$AnimationPlayer.speed_scale = 0.9
	super._ready()

func moveTo(_target:Globals.target):
	super.moveTo(_target)
	if m_currentIntention != "DroneSpawn":
		choseIntention(false)

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.startRound(_heroes,_monsters)
	var rng = RandomNumberGenerator.new()
	m_currentRNG = rng.randf_range(0.0, 1.0)
	
func updateIntentionStatus(_str:String):
	super.updateIntentionStatus(_str)
	
	if _str.contains("DroneSpawn"):
		$CharUI/UIContainer/Control/Icon_Status.setStatus(0,Globals.statusType.INTERRO)
	if _str.contains("Jump"):
		_str.remove_chars("Jump")
		$CharUI/UIContainer/Control/Icon_Status.setStatus(_str.to_int(),Globals.statusType.JUMP)
		
func droneSpawn()->void:
	var slot = Globals.target.ENEMY4
	while m_level.findTargetInSlot(slot) != null:
		slot = (slot as int - 1) as Globals.target
	m_level.createEnemy("Drone",slot)

func updateDisplayIntention():
	match m_currentIntention:
		"DroneSpawn":
			updateIntentionStatus(m_currentIntention)
		"Whip":
			updateIntentionStatus("Jump{dmg}".format({"dmg": str(m_whip)}))
		"Punch":
			updateIntentionStatus("Dmg{dmg}".format({"dmg": str(m_punch)}))
		"Shoot":
			updateIntentionStatus("Dmg{dmg}".format({"dmg": str(m_shoot)}))

func choseIntention(_canChangeToDrone:bool = true):
	var allies = getMonsters()
	if allies.size() == 1 and _canChangeToDrone:
		m_currentIntention = "DroneSpawn"
	elif allies.size() == 2 and m_currentRNG > 0.5 and _canChangeToDrone:
		m_currentIntention = "DroneSpawn"
	elif m_currentPosition > Globals.target.ENEMY1:
		m_currentIntention = "Shoot"
	elif m_currentRNG > 0.5 && m_level.findTargetInSlot(Globals.target.ENEMY2) == null:
		m_currentIntention = "Whip"
	else:
		m_currentIntention = "Punch"

	updateDisplayIntention()

func doWork(_heroes:Array[Character],_allies:Array[Character]) -> void:
	var target = getHeroes().pick_random()
	match m_currentIntention:
		"DroneSpawn":
			droneSpawn()
		"Whip":
			increasePosition()
			target.takeDmg(m_whip,self)
			$AnimationPlayer.play("Whip")
			$AnimationPlayer.queue("Idle")
		"Punch":	
			target.takeDmg(m_punch,self)
			$AnimationPlayer.play("Punch")
			$AnimationPlayer.queue("Idle")
		"Shoot":
			target.takeDmg(m_shoot,self)
			$AnimationPlayer.play("Shoot")
			$AnimationPlayer.queue("Idle")
