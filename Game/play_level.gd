extends Node2D

class_name GameLevel

var m_enemies:Array[Character] = []
var m_turnOver:bool = false
enum turnState{START_COMBAT,ROUND_START,PLAYER_START,PLAYER_END,MONSTER_START,MONSTER_PLAY,MONSTER_END,ROUND_END,NONE,END_COMBAT}
var m_currentTurnState = turnState.START_COMBAT
var m_nextTurnState

func getHeroes()->Array[Character]:
	return $Player.getHeroes()

func getEnemies()->Array[Character]:
	return m_enemies

func createEnemies():
	for enemyName in GpState.getCurrentEnemy():
		createEnemy(enemyName)

func findTargetInSlot(_slot:Globals.target) -> Character:
	for target in m_enemies:
		if target.m_currentPosition == _slot:
			return target
	return null

func getFirstEmptySlot() -> Globals.target:
	var currentPosition = Globals.target.ENEMY1
	var target = findTargetInSlot(currentPosition)
	while target!=null:
		currentPosition = (currentPosition as int + 1) as Globals.target
		target = findTargetInSlot(currentPosition)
	return currentPosition

func createEnemy(_idMob:String,_position:Globals.target = Globals.target.NONE):
	var slot = _position
	if slot == Globals.target.NONE || findTargetInSlot(_position) != null:
		slot = getFirstEmptySlot()
			
	var newEnemy:Character = EnemyFactory.createEnemy(_idMob)
	m_enemies.append(newEnemy)
	$Enemies.add_child(newEnemy)
	newEnemy.connect("OnDeath", onEnemyDeath)
	newEnemy.m_level = self
	newEnemy.m_currentPosition = slot
	setCharacters()
	return newEnemy

func createCards():
	for cardName in GpState.m_cards:
		var newCard = CardFactory.createCard(cardName)
		$UI_Level.addCard(newCard)
		$Player.addCard(newCard)
	$Player.shuffle()

func startCombat():
	m_nextTurnState = turnState.MONSTER_END
	$Player.startCombat()

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
			enemy.doWork($Player.getHeroes(),m_enemies)
	m_nextTurnState = turnState.MONSTER_END
	
func monsterEndRound():
	m_currentTurnState = turnState.MONSTER_END
	for enemy:Character in m_enemies:
		enemy.endRound($Player.getHeroes(),m_enemies)
	m_nextTurnState = turnState.ROUND_END

func endRound():
	m_currentTurnState = turnState.ROUND_END
	m_nextTurnState = turnState.ROUND_START

func endCombat()->void:
	$Player.endCombat()
	$Player.detachHeroes()
	MainUI.goToNextLevel()
	m_nextTurnState = turnState.NONE
	
func setCharacters()->void:
	var characters:Array[Character] = []
	for hero in $Player.getHeroes():
		characters.append(hero)
		hero.m_level = self
	for enemy in m_enemies:
		characters.append(enemy)
	$UI_Level.setCharacters(characters)	

func _ready() -> void:
	createEnemies()
	createCards()
	m_nextTurnState = turnState.START_COMBAT

func onEnemyDeath(_enemy:Character):
	m_enemies.erase(_enemy)
	$Enemies.remove_child(_enemy)
	
	if m_enemies.is_empty():
		m_nextTurnState = turnState.END_COMBAT

func _process(_delta: float) -> void:
	match m_nextTurnState:
		turnState.START_COMBAT:
			startCombat()
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
		turnState.END_COMBAT:
			endCombat()
	

func _on_button_mouse_entered() -> void:
	$Player.m_mouseOverButton = true

func _on_button_mouse_exited() -> void:
	$Player.m_mouseOverButton = false

func _on_ui_level_end_turn_pressed() -> void:
	m_nextTurnState = turnState.PLAYER_END

func _on_ui_level_card_should_be_played(_card:Card,_target:Globals.target) -> void:
	$Player.playCard(_card,m_enemies,_target)
