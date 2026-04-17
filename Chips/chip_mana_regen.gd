extends Chip
class_name chip_manaRagen


func getInfoText()->String:
	return "Regen one extra TC each turn"

func endCombat():
	m_hero.gainTechnoChartreuse(1)
