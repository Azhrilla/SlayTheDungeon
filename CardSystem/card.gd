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

func needTarget() -> bool:
	return false

func attackTarget(_baseDmg:int,_target:Character,_allies:Array[Character]) -> void:
	var attack = atkObject.new()
	attack.m_allies = _allies
	attack.m_baseDmg = _baseDmg
	attack.m_target = _target
	m_player.processPowersWhenAttacking(attack)
	_target.takeDmg(attack.m_baseDmg,getCardActor(_allies))

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
	return _allies[0]

func setPosition(_position:Globals.cardPosition)->void:
	m_currentPosition = _position
	cardNeedUIRefresh.emit(self)

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

func stopParticles():
	$CPUParticles2D.emitting = false

func doWork(_enemies:Array[Character],_allies:Array[Character],_targetPosition:Globals.target):
	push_error("Card does not have a doWork function")

func _on_card_appearance_mouse_entered() -> void:
	mouseHoveredEnter.emit(self)

func _on_card_appearance_mouse_exited() -> void:
	mouseHoveredExit.emit(self)
