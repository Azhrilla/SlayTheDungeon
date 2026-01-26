extends Chip
class_name chip_healthPack
var m_healPerRound = 5

func getInfoText()->String:
	return "Heal {heal} life at the start of each combat.".format({"heal":str(m_healPerRound)})
	
func startCombat():
	m_hero.heal(m_healPerRound)
