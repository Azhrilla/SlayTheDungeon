extends Character

func _ready() -> void:
	m_currentHealth = 40
	super._ready()
	m_type = Globals.type.HERO
	$Sprite2D2/AnimationPlayer.play("idle")
