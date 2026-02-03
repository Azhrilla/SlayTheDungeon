extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.visible = false

func startShield():
	$Sprite2D.visible = true
	$AnimationPlayer.play("Idle")
	
func stopShield():
	$Sprite2D.visible = false
	$AnimationPlayer.stop()
