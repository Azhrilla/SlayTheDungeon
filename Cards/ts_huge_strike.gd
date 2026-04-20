extends Card

@export var m_damage:int = 10
@export var m_damageUpgrade:int = 20


func _ready():
	var cardText = $cardText.text
	$cardText.text = cardText.format({"dmg":str(m_damage)})
	cardText = $textUpgrade.text
	$textUpgrade.text = cardText.format({"dmg":str(m_damageUpgrade)})

func doWorkUpgraded(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	var target = findTargetInSlot(_enemies,Globals.target.ENEMY1)
	if (target):
		attackTarget(m_damageUpgrade,target,_hero)
		
	target = findTargetInSlot(_enemies,Globals.target.ENEMY2)
	if (target):
		attackTarget(m_damageUpgrade,target,_hero)

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	var target = findTargetInSlot(_targets,Globals.target.ENEMY1)
	if (target):
		attackTarget(m_damage,target,_hero)
		
	target = findTargetInSlot(_targets,Globals.target.ENEMY2)
	if (target):
		attackTarget(m_damage,target,_hero)
