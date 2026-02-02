extends Chip
class_name chip_ramp
var m_cardCount = 0
var m_cardTarget = 7

func getInfoText()->String:
	return "Give 1 strength after playing {card} cards. (atm : {current})".format({"card":str(m_cardTarget),"current":str(m_cardCount)})

func cardPlayed(_card:Card):
	m_cardCount +=1
	if m_cardCount == m_cardTarget:
		m_hero.addToStatusVariable(Globals.statusType.STR,1)
		m_cardCount = 0
