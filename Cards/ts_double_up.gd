extends Card

@export var m_damage:int = 5
@export var m_critDmg:int = 10

func _ready() -> void:
	var cardText = $cardText.text
	$cardText.text = cardText.format({"dmg":str(m_damage),"crit":str(m_critDmg)})

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		var target = findTargetInSlot(_targets,index)
		if target:
			var isTargetKilled = attackTarget(m_damage,target,_allies)
			var target2 = findTargetInSlot(_targets,index+1)
			if target2:
				var newDmg = m_damage
				if isTargetKilled:
					newDmg = m_critDmg
				attackTarget(newDmg,target2,_allies)
			return
