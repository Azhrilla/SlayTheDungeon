extends Character
class_name Enemy

var m_intentions:Array[Intention] = []
var m_currentIntention:Intention = null
var m_defaultWeightsIntentions = []

func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("Idle")
	m_type = Globals.type.MONSTER
	if Globals.m_godMode:
		m_currentHealth = 1

func doWork(_hero:Character,_allies:Array[Character]) -> void:
	if m_currentIntention:
		m_currentIntention.doWork(self,_hero,_allies,m_level)

func setIntention(_intent:Intention)->void:
	m_currentIntention = _intent
	_intent.updateIntentionStatus($CharUI/UIContainer/Control/Icon_Status)

func choseIntention():
	var rng = RandomNumberGenerator.new()
	setIntention(m_intentions[rng.rand_weighted(m_defaultWeightsIntentions)])
	return

func increasePosition() -> void:
	if m_currentPosition != Globals.target.ENEMY4:
		moveTo(m_currentPosition + 1)

func decreasePosition() -> void:
	if m_currentPosition != Globals.target.ENEMY1:
		moveTo(m_currentPosition - 1)

func playAnim(_str:String,_shouldBackToIdle = true) -> void:
	$AnimationPlayer.play(_str)
	if _shouldBackToIdle:
		$AnimationPlayer.queue("Idle")

func playAnimBackward(_str:String,_shouldBackToIdle = true) -> void:
	$AnimationPlayer.play_backwards(_str)
	if _shouldBackToIdle:
		$AnimationPlayer.queue("Idle")

func startRound(_hero:Character,_monsters:Array[Character]):
	super.startRound(_hero,_monsters)
	
func endRound(_hero:Character,_monsters:Array[Character]):
	super.endRound(_hero,_monsters)
	choseIntention()
	
