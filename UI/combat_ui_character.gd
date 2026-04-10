extends Control


@onready var m_characterUI = $VBoxForInfos/ComponentUICharacter
@onready var m_chartreuseCount = $VBoxForInfos/BackGround/VBoxContainer/Control/ChartreuseCount
@onready var m_dollarLabel = $VBoxForInfos/BackGround/VBoxContainer/DollarsLabel
@onready var m_chipsContainer = $VBoxForInfos/BackGround/VBoxContainer/ChipContainer
@onready var m_chipInfo = $VBoxForInfos/ControlForChips/ChipInfo
@onready var m_chipInfoText = $VBoxForInfos/ControlForChips/ChipInfo/ChipInfoText

func init(_hero:Hero)->void:
	for myChip:Chip in _hero.m_chips:
		myChip.mouseEntered.connect(mouseEnteredChip)
		myChip.mouseExited.connect(mouseExitedChip)
		if myChip.get_parent():
			myChip.get_parent().remove_child(myChip)
		m_chipsContainer.add_child(myChip)
	m_dollarLabel.text=str(GpState.m_currentDollars)
	GpState.onDollarChanged.connect(onDollarChanged)
	_hero.onTechnoChartreuseUsed.connect(onTechnoChanged)
	m_chartreuseCount.frame = _hero.getCurrentTechnoChartreuseCount()
	m_characterUI.init(_hero)

func release(_hero:Hero)->void:
	for myChip:Chip in _hero.m_chips:
		if myChip.get_parent():
			myChip.get_parent().remove_child(myChip)
		_hero.add_child(myChip)

func onTechnoChanged(_count:int)->void:
	m_chartreuseCount.frame = _count

func mouseEnteredChip(_chip:Chip):
	m_chipInfo.visible = true
	m_chipInfoText.text = _chip.getInfoText()

func mouseExitedChip(_chip:Chip):
	m_chipInfo.visible = false

func onDollarChanged():
	m_dollarLabel.text=str(GpState.m_currentDollars)
