extends Character
class_name Hero
var m_chips: Array[Chip]


func processAttacks(_attack:atkObject) -> void:
	_attack.m_baseDmg += getStatusVariable(Globals.statusType.STR)
	for chip in m_chips:
		chip.processChipsWhileAttacking(_attack)

func startCombat():
	for chip in m_chips:
		chip.startCombat()
	
func endCombat():
	setStatusVariable(Globals.statusType.STR,0)
	setStatusVariable(Globals.statusType.ARMOR,0)
	for chip in m_chips:
		chip.endCombat()

func cardPlayed(_card:Card):
	for chip in m_chips:
		chip.cardPlayed(_card)

func addChip(_chip:Chip)->void:
	_chip.m_hero = self
	m_chips.append(_chip)

func _ready() -> void:
	m_currentHealth = 40
	m_startingHealth = 40
	super._ready()
	m_type = Globals.type.HERO
	$Sprite2D2/AnimationPlayer.play("idle")
