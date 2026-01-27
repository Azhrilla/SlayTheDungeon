extends Node

var m_hero:Hero = null
var m_cards:Array[String] = ["QuickSlash","QuickSlash","QuickSlash","Slash","Slash","Slash","Slash","Grab","Grab","Grab","Defense","Defense","Defense","Defense","Defense"]
var m_currentLevel:levelInfos = null
var m_currentDollars:int:
	set = setDollars

func setDollars(_value:int)->void:
	MainUI.setDollars(_value)
	m_currentDollars = _value
