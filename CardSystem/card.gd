extends Control
class_name Card
signal mouseHoveredEnter
signal mouseHoveredExit
signal cardNeedUIRefresh

var m_name:String = "noname"
var m_text:String = "filler Text"
var m_currentPosition:Globals.cardPosition = Globals.cardPosition.NONE
var m_player = null
var m_cardType = Globals.cardType.NORMAL
var m_targetType:Globals.cardTarget = Globals.cardTarget.NONE
var tweenPosition = null

func attackTarget(_baseDmg:int,_target:Character,_hero:Character) -> bool:
	var attack = atkObject.new()
	attack.m_hero = _hero
	attack.m_baseDmg = _baseDmg
	attack.m_target = _target
	m_player.processPowersWhenAttacking(attack)
	print ("Card {card} will attack target {target} for {dmg} dmg".format({"dmg":str(attack.m_baseDmg),"card":str(m_name),"target":str(_target.m_name)}))
	return _target.takeDmg(attack.m_baseDmg,_hero)

func getTargetType() -> Globals.cardTarget:
	return m_targetType

func _ready() -> void:
	updateVisibility()
	$cardText.label_settings.font_color=Color(0,0,0,1)
	$cardText.label_settings.font_size=12

func findTargetInSlot(_targets:Array[Character],_slot:Globals.target) -> Character:
	for target in _targets:
		if target.m_currentPosition == _slot:
			return target
	return null

func getCardActor(_allies:Array[Character])->Character:
	if _allies.is_empty():
		return null
	return _allies[0]

func setPosition(_position:Globals.cardPosition)->void:
	m_currentPosition = _position
	cardNeedUIRefresh.emit(self)

func setGlobalPosition(_position:Vector2)->void:
	if tweenPosition:
		tweenPosition.kill() # Avorter l'animation précédente.
	tweenPosition = create_tween()
	tweenPosition.tween_property(self, "position", _position, 0.1)


func setCardState(_state:Globals.cardState)->void:
	match _state:
		Globals.cardState.PLAYABLE:
			startParticles()
			scale = Vector2(1.3,1.3)
		Globals.cardState.HOVERED:
			stopParticles()
			scale = Vector2(1.1,1.1)
		Globals.cardState.DEFAULT:
			stopParticles()
			scale = Vector2.ONE

func updateVisibility():
		$CardAppearance.visible = true
		$cardName.visible = true
		$cardText.visible = true

func startParticles():
	$CPUParticles2D.emitting = true
	$GlowAuraCard.enabled = true

func stopParticles():
	$CPUParticles2D.emitting = false
	$GlowAuraCard.enabled = false

func doWork(_enemies:Array[Character],_hero:Character,_targetPosition:Globals.target):
	push_error("Card does not have a doWork function")

func _on_card_appearance_mouse_entered() -> void:
	mouseHoveredEnter.emit(self)

func _on_card_appearance_mouse_exited() -> void:
	mouseHoveredExit.emit(self)
