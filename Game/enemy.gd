extends Character
class_name Enemy

var m_intentions:Array[String] = []
var m_currentIntention:String = ""

func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("Idle")
	m_type = Globals.type.MONSTER

func attack(_heroes:Array[Character]) -> void:
	pass

func playAttackAnim() -> void:
	$AnimationPlayer.play("Attack")
	$AnimationPlayer.queue("Idle")

func updateIntentionStatus(_str:String):
	if _str.contains("Dmg"):
		_str.remove_chars("Dmg")
		$CharUI/UIContainer/Control/Icon_Status.setStatus(_str.to_int(),Globals.statusType.DMG)

func choseIntention():
	m_currentIntention = m_intentions.pick_random()
	updateIntentionStatus(m_currentIntention)

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.startRound(_heroes,_monsters)
	
func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.endRound(_heroes,_monsters)
	choseIntention()
	
