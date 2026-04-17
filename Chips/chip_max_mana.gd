extends Chip
class_name chip_maxMana


func getInfoText()->String:
	return "Increase Max Mana by 1"

func setHero(_hero:Hero):
	super.setHero(_hero)
	m_hero.m_maxTechnoChartreuse +=1
