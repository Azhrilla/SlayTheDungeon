extends Node2D

var m_enemies:Array[Character] = []
var m_turnOver:bool = false
enum turnState{ROUND_START,PLAYER_START,PLAYER_END,MONSTER_START,MONSTER_PLAY,MONSTER_END,ROUND_END,NONE}
var m_currentTurnState = turnState.NONE
var m_nextTurnState

func createEnemies():
	var positionEnemy = Globals.target.ENEMY1
	for enemyName in GpState.m_currentLevel:
		var newEnemy:Character = EnemyFactory.createEnemy(enemyName)
		newEnemy.m_currentPosition = positionEnemy
		m_enemies.append(newEnemy)
		$Enemies.add_child(newEnemy)
		newEnemy.connect("OnDeath", onEnemyDeath)
		positionEnemy = (positionEnemy as int + 1) as Globals.target

func createCards():
	for cardName in GpState.m_cards:
		var newCard = CardFactory.createCard(cardName)
		$UI_Level.addCard(newCard)
		$Player.addCard(newCard)
	$Player.shuffle()

func startRound():
	m_currentTurnState = turnState.ROUND_START
	m_nextTurnState = turnState.PLAYER_START

func playerStartRound():
	m_currentTurnState = turnState.PLAYER_START
	$Player.startRound($Player.getHeroes(),m_enemies)
	m_nextTurnState = turnState.NONE
	
func playerEndRound():
	m_currentTurnState = turnState.PLAYER_END
	$Player.endRound($Player.getHeroes(),m_enemies)
	m_nextTurnState = turnState.MONSTER_START
	
func monsterStartRound():
	m_currentTurnState = turnState.MONSTER_START
	for enemy:Character in m_enemies:
		enemy.startRound($Player.getHeroes(),m_enemies)
	m_nextTurnState = turnState.MONSTER_PLAY

func monsterPlay():
	m_currentTurnState = turnState.MONSTER_PLAY
	for enemy:Character in m_enemies:
		if !$Player.getHeroes().is_empty():
			enemy.attack($Player.getHeroes())
	m_nextTurnState = turnState.MONSTER_END
	
func monsterEndRound():
	m_currentTurnState = turnState.MONSTER_END
	for enemy:Character in m_enemies:
		enemy.endRound($Player.getHeroes(),m_enemies)
	m_nextTurnState = turnState.ROUND_END

func endRound():
	m_currentTurnState = turnState.ROUND_END
	m_nextTurnState = turnState.ROUND_START


func _ready() -> void:
	createEnemies()
	var characters:Array[Character] = []
	for hero in $Player.getHeroes():
		characters.append(hero)
	for enemy in m_enemies:
		characters.append(enemy)
	$UI_Level.setCharacters(characters)
	createCards()
	m_nextTurnState = turnState.MONSTER_END

func endCombat()->void:
	$Player.detachHeroes()
	TransitionLayer.switchLevel("res://UI/add_card_menu.tscn")

func onEnemyDeath(_enemy:Character):
	m_enemies.erase(_enemy)
	$Enemies.remove_child(_enemy)
	
	if m_enemies.is_empty():
		endCombat()

func _process(_delta: float) -> void:
	match m_nextTurnState:
		turnState.ROUND_START:
			startRound()
		turnState.PLAYER_START:
			playerStartRound()
		turnState.PLAYER_END:
			playerEndRound()
		turnState.MONSTER_START:
			monsterStartRound()
		turnState.MONSTER_PLAY:
			monsterPlay()
		turnState.MONSTER_END:
			monsterEndRound()
		turnState.ROUND_END:
			endRound()
	
	

func _on_button_mouse_entered() -> void:
	$Player.m_mouseOverButton = true

func _on_button_mouse_exited() -> void:
	$Player.m_mouseOverButton = false

func _on_ui_level_end_turn_pressed() -> void:
	m_nextTurnState = turnState.PLAYER_END

func _on_ui_level_card_should_be_played(_card:Card,_target:Globals.target) -> void:
	$Player.playCard(_card,m_enemies,_target)
