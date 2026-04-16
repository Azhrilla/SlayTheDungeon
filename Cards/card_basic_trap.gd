extends Card
class_name BasicTrap

const trapScene:PackedScene = preload("res://Game/Traps/trap_dmg_trap.tscn")
@export var m_dmg = 10

func _init() -> void:
	m_canBeUpgraded = true
	
func _ready() -> void:
	super._ready()
	m_cardType = Globals.cardType.TRAP
	m_targetType = Globals.cardTarget.EMPTY
	
func getUpgradedTargetType():
	return Globals.cardTarget.NONE

func doWorkUpgraded(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		if _hero.m_level.m_UILevel.m_characterUIComponent.isTargetControlZoneEmptyAndUntrapped(index):
			var trap:Trap_DmgTrap = trapScene.instantiate()
			trap.m_dmg = m_dmg
			trap.m_position = index
			_hero.addTrap(trap)

func doWork(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	var trap:Trap_DmgTrap = trapScene.instantiate()
	trap.m_dmg = m_dmg
	trap.m_position = _targetPosition
	_hero.addTrap(trap)
