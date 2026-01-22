extends Chip
class_name chip_firstStrike
var m_chipReady = true

func startCombat():
	m_chipReady = true

func processChipsWhileAttacking(_attack:atkObject):
	if m_chipReady:
		_attack.m_baseDmg += 10
		m_chipReady = false
