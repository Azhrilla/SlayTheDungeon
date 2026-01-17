extends Character
class_name Enemy

var m_intentions:Array[String] = []
var m_currentIntention:String = ""

func _ready() -> void:
	super._ready()
	m_type = Globals.type.MONSTER

func attack(_heroes:Array[Character]) -> void:
	pass

func choseIntention():
	m_currentIntention = m_intentions.pick_random()
	$Intention.text = "Intent: "+m_currentIntention

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	choseIntention()
	
func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	attack(_heroes)
	
