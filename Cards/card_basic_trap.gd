extends Card
class_name BasicTrap

const trapScene:PackedScene = preload("res://Game/Traps/trap_dmg_trap.tscn")
@export var m_dmg = 10
func _ready() -> void:
	super._ready()
	m_cardType = Globals.cardType.TRAP
	m_targetType = Globals.cardTarget.EMPTY

func doWork(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	var trap:Trap_DmgTrap = trapScene.instantiate()
	trap.m_dmg = m_dmg
	trap.m_position = _targetPosition
	_hero.addTrap(trap)
