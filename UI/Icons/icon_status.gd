extends Control

var m_statusType:Globals.statusType = Globals.statusType.NONE

func setStatus(_value:int,_statusType:Globals.statusType):
	$value.text = str(_value)
	if _value == 0:
		$value.visible = false
	else:
		$value.visible = true
	
	if m_statusType == _statusType:
		return
		
	m_statusType = _statusType
	match _statusType:
		Globals.statusType.SPIKE:
			var texturePath= "res://Graphics/UI/Icons/lightning.png"
			var texture2d = load(texturePath)
			$TextureStatus.texture = texture2d;
		Globals.statusType.ARMOR:
			var texturePath= "res://Graphics/UI/Icons/shield.png"
			var texture2d = load(texturePath)
			$TextureStatus.texture = texture2d;
		Globals.statusType.DMG:
			var texturePath= "res://Graphics/UI/Icons/target.png"
			var texture2d = load(texturePath)
			$TextureStatus.texture = texture2d;
