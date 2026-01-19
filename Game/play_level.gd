extends Node2D

var enemyScene:PackedScene = preload("res://Enemies/enemy_flame.tscn")
var m_enemies:Array[Character] = []
var m_turnOver:bool = false

func createEnemies():
	var positionEnemy = Globals.target.ENEMY1
	for enemyName in Globals.m_currentLevel:
		var newEnemy:Character = EnemyFactory.createEnemy(enemyName)
		newEnemy.m_currentPosition = positionEnemy
		m_enemies.append(newEnemy)
		$Enemies.add_child(newEnemy)
		newEnemy.connect("OnDeath", onEnemyDeath)
		positionEnemy = (positionEnemy as int + 1) as Globals.target

func createCards():
	for cardName in Globals.m_cards:
		var newCard = CardFactory.createCard(cardName)
		$UI_Level.addCard(newCard)
		$Player.addCard(newCard)
	$Player.shuffle()

func newRound():
	$Player.startRound($Player.getHeroes(),m_enemies)
	for enemy:Character in m_enemies:
		enemy.startRound($Player.getHeroes(),m_enemies)
	m_turnOver = false
	
func endRound():
	for enemy:Character in m_enemies:
		enemy.endRound($Player.getHeroes(),m_enemies)
	$Player.endRound($Player.getHeroes(),m_enemies)
	m_turnOver = true
	
func _ready() -> void:
	createEnemies()
	var characters:Array[Character] = []
	for hero in $Player.getHeroes():
		characters.append(hero)
	for enemy in m_enemies:
		characters.append(enemy)
	$UI_Level.setCharacters(characters)
	createCards()
	newRound()

func onEnemyDeath(_enemy:Character):
	m_enemies.erase(_enemy)
	$Enemies.remove_child(_enemy)
	if m_enemies.is_empty():
		TransitionLayer.switchLevel("res://UI/add_card_menu.tscn")

func _process(_delta: float) -> void:
	if m_turnOver:
		newRound()

func _on_button_mouse_entered() -> void:
	$Player.m_mouseOverButton = true

func _on_button_mouse_exited() -> void:
	$Player.m_mouseOverButton = false

func _on_ui_level_end_turn_pressed() -> void:
	endRound()

func _on_ui_level_card_should_be_played(_card:Card,_target:Globals.target) -> void:
	$Player.playCard(_card,m_enemies,_target)
