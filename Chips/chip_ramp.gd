extends Chip
class_name chip_ramp
var m_cardCount = 0
var m_cardTarget = 7

func cardPlayed(_card:Card):
	m_cardCount +=1
	if m_cardCount == m_cardTarget:
		m_hero.m_strength +=1
		m_cardCount = 0
