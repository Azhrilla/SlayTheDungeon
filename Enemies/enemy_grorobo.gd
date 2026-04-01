extends Enemy

@export var MAX_HEALTH:int  = 80 
@export var m_punch:int = 8
@export var m_whip:int = 7
@export var m_shoot:int = 6
var m_currentRNG = 0

var bossAttacks: Dictionary[String,Intention] ={
		"Whip":Intention_Hit_N_Run.new(m_whip),
		"Shoot":Intention_SimpleDmg.new(m_shoot,"Shoot"),
		"Drone":Intention_DroneSpawn.new(),
		"Punch":Intention_SimpleDmg.new(m_punch,"Punch"),
	}

func _ready() -> void:
	m_maximumHealth = MAX_HEALTH
	m_currentPosition = Globals.target.ENEMY2
	$AnimationPlayer.speed_scale = 0.9
	super._ready()

func moveTo(_target:Globals.target):
	super.moveTo(_target)
	if !m_currentIntention is Intention_DroneSpawn:
		choseIntention(false)

func startRound(_hero:Character,_monsters:Array[Character]):
	super.startRound(_hero,_monsters)
	var rng = RandomNumberGenerator.new()
	m_currentRNG = rng.randf_range(0.0, 1.0)


func choseIntention(_canChangeToDrone:bool = true):
	var allies = getMonsters()
	if allies.size() == 1 and _canChangeToDrone:
		setIntention(bossAttacks["Drone"])
	elif allies.size() == 2 and m_currentRNG > 0.5 and _canChangeToDrone:
		setIntention(bossAttacks["Drone"])
	elif m_currentPosition > Globals.target.ENEMY1:
		setIntention(bossAttacks["Shoot"])
	elif m_currentRNG > 0.5 && m_level.findTargetInSlot(Globals.target.ENEMY2) == null:
		setIntention(bossAttacks["Whip"])
	else:
		setIntention(bossAttacks["Punch"])
