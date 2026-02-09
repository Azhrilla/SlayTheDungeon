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

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.startRound(_heroes,_monsters)
	for chip in m_chips:
		chip.startRound()

func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	super.endRound(_heroes,_monsters)
	for chip in m_chips:
		chip.endRound()

func endCombat():
	m_armorIsPermanent = false
	
	for statusType in Globals.statusType.values():
		setStatusVariable(statusType,0)

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
	m_maximumHealth = 40
	super._ready()
	m_type = Globals.type.HERO
	$Sprite2D2/AnimationPlayer.play("idle")
