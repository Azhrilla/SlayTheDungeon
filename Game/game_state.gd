extends Node

var m_hero:Hero = null
var m_cards:Array[String] = ["QuickSlash","QuickSlash","QuickSlash","Slash","Slash","Slash","Slash","Grab","Grab","Grab","Defense","Defense","Defense","Defense","Defense"]
var m_currentDollars:int:
	set = setDollars

var m_currentBloc:BlocSystem = null

func getCurrentEnemy()->Array[String]:
	return m_currentBloc.getCurrentEnemies()

func getCurrentLevel()->levelInfos:
	return m_currentBloc.m_currentLevel

func setDollars(_value:int)->void:
	MainUI.setDollars(_value)
	m_currentDollars = _value

func _process(_delta: float) -> void:
	EnemyFactory.statusLoading()
