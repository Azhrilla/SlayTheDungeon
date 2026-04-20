extends Card

@export var m_damage:int = 5
@export var m_damageUpgraded:int = 10


func doWorkUpgraded(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	for target in _enemies:
		attackTarget(m_damageUpgraded,target,_hero)

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	for target in _targets:
		attackTarget(m_damage,target,_hero)
