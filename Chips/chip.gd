extends Control
class_name Chip

var m_hero:Hero = null

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
	mouse_entered.emit(self)

func _on_texture_rect_mouse_exited() -> void:
	mouse_exited.emit(self)
