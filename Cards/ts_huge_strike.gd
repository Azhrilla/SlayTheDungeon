extends Card

@export var m_damage:int = 10

func _ready():
	var cardText = $cardText.text
	$cardText.text = cardText.format({"dmg":str(m_damage)})

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	var target = findTargetInSlot(_targets,Globals.target.ENEMY1)
	if (target):
		attackTarget(m_damage,target,_allies)
		
	target = findTargetInSlot(_targets,Globals.target.ENEMY2)
	if (target):
		attackTarget(m_damage,target,_allies)
