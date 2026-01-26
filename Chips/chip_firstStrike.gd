extends Chip
class_name chip_firstStrike
var m_chipReady = true
var m_extraDmg = 10

func getInfoText()->String:
	return "The first attack of each round will deal {dmg} extra dmg.".format({"dmg":str(m_extraDmg)})

func startCombat():
	m_chipReady = true

func processChipsWhileAttacking(_attack:atkObject):
	if m_chipReady:
		_attack.m_baseDmg += m_extraDmg
		m_chipReady = false
