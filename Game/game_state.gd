extends Node

const heroScene:PackedScene = preload("res://Game/hero.tscn")

var m_starterCards:Array[String] = ["BasicTrap","QuickSlash","QuickSlash","QuickSlash","Slash","Slash","Slash","Grab","Grab","Grab","Defense","Defense","Defense","Defense","Defense"]
var m_hero:Hero = null
var m_cards:Array[String] = []
var m_currentDollars:int:
	set = setDollars

signal onDollarChanged

var m_currentBloc:BlocSystem = null

func getHero():
	if !m_hero:
		resetGPState()
		m_hero = heroScene.instantiate()
	return m_hero

func resetGPState() -> void:
	m_cards.clear()
	m_cards.append_array(m_starterCards)
	m_hero = null
	m_currentDollars = 100

func getCurrentEnemy()->Array[String]:
	return m_currentBloc.getCurrentEnemies()

func getCurrentLevel()->levelInfos:
	return m_currentBloc.m_currentLevel

func setDollars(_value:int)->void:
	m_currentDollars = _value
	onDollarChanged.emit()

func _process(_delta: float) -> void:
	EnemyFactory.statusLoading()
