extends Card

func _ready() -> void:
	super._ready()
	m_targetType = Globals.cardTarget.ENEMY
	
func doWork(_targets:Array[Character],_hero:Character,_targetPosition:Globals.target):
	var target:Character = findTargetInSlot(_targets,_targetPosition)
	var buffAvaialbles:Array[Globals.statusType] = target.getBuffStatusList()
	if buffAvaialbles.is_empty():
		return
	var buffToHalves:Globals.statusType = buffAvaialbles.pick_random()
	var newValue:int = target.getStatusVariable(buffToHalves)/ 2
	target.setStatusVariable(buffToHalves,newValue)
