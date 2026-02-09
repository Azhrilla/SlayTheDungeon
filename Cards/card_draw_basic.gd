extends Card

func needTarget() -> bool:
	return false

func doWork(_targets:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	m_player.drawCard()
	m_player.drawCard()
