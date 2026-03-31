extends Control


@onready var m_characterUI = $ComponentUICharacter

func init(_hero:Hero)->void:
	for myChip:Chip in _hero.m_chips:
		myChip.mouseEntered.connect(mouseEnteredChip)
		myChip.mouseExited.connect(mouseExitedChip)
		if myChip.get_parent():
			myChip.get_parent().remove_child(myChip)
		$BackGround/ChipContainer.add_child(myChip)
	$BackGround/DollarsLabel.text=str(GpState.m_currentDollars)
	GpState.onDollarChanged.connect(onDollarChanged)

	m_characterUI.init(_hero)

func release(_hero:Hero)->void:
	for myChip:Chip in _hero.m_chips:
		if myChip.get_parent():
			myChip.get_parent().remove_child(myChip)
		_hero.add_child(myChip)
		
		
func mouseEnteredChip(_chip:Chip):
	$ChipInfo.visible = true
	$ChipInfo/ChipInfoText.text = _chip.getInfoText()

func mouseExitedChip(_chip:Chip):
	$ChipInfo.visible = false

func onDollarChanged():
	$BackGround/DollarsLabel.value=GpState.m_currentDollars
