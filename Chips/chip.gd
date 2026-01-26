extends Control
class_name Chip

var m_hero:Hero = null
signal mouseEntered()
signal mouseExited()

func processChipsWhileAttacking(_attack:atkObject) -> void:
	pass

func startCombat():
	pass
	
func endCombat():
	pass	

func cardPlayed(_card:Card):
	pass

func getInfoText()->String:
	return "Text not set for this chip"

func _on_texture_rect_mouse_entered() -> void:
	mouseEntered.emit(self)

func _on_texture_rect_mouse_exited() -> void:
	mouseExited.emit(self)
