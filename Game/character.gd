extends Node

class_name Character
var m_currentHealth = 0
var m_currentArmor = 0
var m_type = Globals.type.NONE
signal OnDeath
signal mouseOver(_char:Character)

var m_currentPosition = 0
var m_spikeDmg:int = 0

func startRound(_heroes:Array[Character],_monsters:Array[Character]):
	pass
	
func endRound(_heroes:Array[Character],_monsters:Array[Character]):
	pass

func _ready() -> void:
	$HealthBar.max_value = m_currentHealth
	
func _process(_delta: float) -> void:
	$HealthBar.value = m_currentHealth
	var buffText:String = ""
	if m_currentArmor > 0:
		buffText += "Armor:{0}".format([m_currentArmor])
	if m_spikeDmg > 0:
		buffText += "Spike:{0}".format([m_spikeDmg])
	$ArmorValue.text = buffText
	$HealthValue.text = "PVs:{0}".format([m_currentHealth])

func useArmorAndGetDmg(_dmg:int) -> int:
	var absorbedDmg = min(m_currentArmor,_dmg)
	var effectiveDmg:int = _dmg - absorbedDmg
	m_currentArmor -= absorbedDmg
	return effectiveDmg

func increasePosition() -> void:
	if m_currentPosition != Globals.target.ENEMY4:
		moveTo(m_currentPosition + 1)

func decreasePosition() -> void:
	if m_currentPosition != Globals.target.ENEMY1:
		moveTo(m_currentPosition - 1)

func moveTo(_target:Globals.target)->void:
	m_currentPosition = _target

func onDamageTaken(_effectiveDmg:int,_attacker:Character):
	_attacker.takeDmg(m_spikeDmg,self)

func takeDmg(_dmg:int,_attacker:Character,_isAttackFirstTrigger:bool = true):
	var effectiveDmg:int =useArmorAndGetDmg(_dmg)
	
	if effectiveDmg == 0:
		return
		
	if _isAttackFirstTrigger:
		onDamageTaken(effectiveDmg,_attacker)
		
	m_currentHealth -= effectiveDmg
	
	if m_currentHealth<=0:
		OnDeath.emit(self)
	
func addArmor(_armor:int):
	m_currentArmor+=_armor

func _on_mouse_entered() -> void:
	mouseOver.emit(self)
