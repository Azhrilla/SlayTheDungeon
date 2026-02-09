extends Card

@export var m_damage:int = 10
@export var m_diminution:int = 2

func _ready() -> void:
	var cardText = $cardText.text
	$cardText.text = cardText.format({"dmg":str(m_damage),"minus":str(m_diminution)})

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	var currentDmg = m_damage
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		var target = findTargetInSlot(_targets,index)
		if target:
			attackTarget(currentDmg,target,_allies)
			currentDmg -= m_diminution
