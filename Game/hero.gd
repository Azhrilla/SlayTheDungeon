extends Character
class_name Hero

const objectScene:PackedScene = preload("res://Ojects/object_techno_canon.tscn")

signal onTechnoChartreuseUsed 

var m_chips: Array[Chip]
var m_objects:Array[ObjectBase]
var m_technoChartreuse:int = 3
var m_maxTechnoChartreuse:int = 3

func processAttacks(_attack:atkObject) -> void:
	_attack.m_baseDmg += getStatusVariable(Globals.statusType.STR)
	for chip in m_chips:
		chip.processChipsWhileAttacking(_attack)

func addTrap(_trap:TrapBase)->void:
	m_level.addTrap(_trap)

func getObjects()->Array[ObjectBase]:
	return m_objects
	
func getCurrentTechnoChartreuseCount():
	return m_technoChartreuse

func gainTechnoChartreuse(_amount:int):
	m_technoChartreuse += _amount
	m_technoChartreuse = clamp(m_technoChartreuse,0,m_maxTechnoChartreuse)
	onTechnoChartreuseUsed.emit(m_technoChartreuse)

func canObjectBeUsed(_object:ObjectBase)->bool:
	if _object.getCost() > m_technoChartreuse:
		return false
	else:
		return true

func useObject(_targets:Array[Character],_objectUsed:ObjectBase,_targetPosition:Globals.target):
	_objectUsed.doWork(_targets,self,_targetPosition)
	m_technoChartreuse -= _objectUsed.getCost()
	onTechnoChartreuseUsed.emit(m_technoChartreuse)

func startCombat():
	for chip in m_chips:
		chip.startCombat()

func startRound(_hero:Character,_monsters:Array[Character]):
	super.startRound(_hero,_monsters)
	for chip in m_chips:
		chip.startRound()

func endRound(_hero:Character,_monsters:Array[Character]):
	super.endRound(_hero,_monsters)
	for chip in m_chips:
		chip.endRound()

func endCombat():
	m_armorIsPermanent = false
	gainTechnoChartreuse(1)
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

func _init():
	var newObject:ObjectBase = objectScene.instantiate()
	m_objects.append(newObject)
	
func _ready() -> void:
	m_currentHealth = 50
	m_maximumHealth = 50
	super._ready()
	m_type = Globals.type.HERO
	
