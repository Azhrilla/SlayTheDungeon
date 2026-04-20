extends Card

@export var m_damage:int = 5
@export var m_dmgUpgraded:int = 10
@export var m_critDmg:int = 20

func doWorkUpgraded(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		var target = findTargetInSlot(_enemies,index)
		if target:
			var isTargetKilled = attackTarget(m_dmgUpgraded,target,_hero)
			var target2 = findTargetInSlot(_enemies,index+1)
			if target2:
				var newDmg = m_dmgUpgraded
				if isTargetKilled:
					newDmg = m_critDmg
				attackTarget(newDmg,target2,_hero)
			return

func _ready() -> void:
	var cardText = $cardText.text
	$cardText.text = cardText.format({"dmg":str(m_damage),"crit":str(m_critDmg)})
	cardText = $textUpgrade.text
	$textUpgrade.text = cardText.format({"dmg":str(m_dmgUpgraded)})

func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	
	for index in range(Globals.target.ENEMY1,Globals.target.ENEMY4+1):
		var target = findTargetInSlot(_targets,index)
		if target:
			var isTargetKilled = attackTarget(m_damage,target,_hero)
			var target2 = findTargetInSlot(_targets,index+1)
			if target2:
				var newDmg = m_damage
				if isTargetKilled:
					newDmg = m_critDmg
				attackTarget(newDmg,target2,_hero)
			return
