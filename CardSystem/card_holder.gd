extends Node2D

class_name CardHolder

enum visibleSide{BACK, FRONT}


var m_discard: Array[Card] = []
var m_hand: Array[Card] = []
var m_deck: Array[Card] = []
var m_powers: Array[Card] = []

func shuffle():
	m_deck.shuffle()

func addCard(_card:Card,_cardPosition = Globals.cardPosition.DECK)->void:
	match _cardPosition:
		Globals.cardPosition.DECK:
			m_deck.append(_card)
		Globals.cardPosition.HAND:
			m_hand.append(_card)
		Globals.cardPosition.DISCARD:
			m_discard.append(_card)
		Globals.cardPosition.POWER:
			m_powers.append(_card)
	_card.setPosition(_cardPosition)
	
func getCardCount(_from:Globals.cardPosition) -> int:
	return getCardContainer(_from).size()

func getCardContainer(_from:Globals.cardPosition) -> Array[Card]:
	match _from:
		Globals.cardPosition.DECK:
			return m_deck
		Globals.cardPosition.HAND:
			return m_hand
		Globals.cardPosition.DISCARD:
			return m_discard
		Globals.cardPosition.POWER:
			return m_powers
		_:
			push_error("should not happen : non correct card container")
			var output = []
			return output


func moveCard(_card:Card,_from:Globals.cardPosition,_to:Globals.cardPosition):
	if !getCardContainer(_from).has(_card):
		push_error ("error the card is not found in the desired pile")
	var indexCard = getCardContainer(_from).find(_card)
	getCardContainer(_to).append(getCardContainer(_from).pop_at(indexCard))
	_card.setPosition(_to)

func drawCard():
	if (m_deck.is_empty()):
		for card:Card in m_discard:
			moveCard(card,Globals.cardPosition.DISCARD,Globals.cardPosition.DECK)
		getCardContainer(Globals.cardPosition.DECK).shuffle()
	if (m_deck.is_empty()):
		return		
	moveCard(getCardContainer(Globals.cardPosition.DECK)[0],Globals.cardPosition.DECK,Globals.cardPosition.HAND)
