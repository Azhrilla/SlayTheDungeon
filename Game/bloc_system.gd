class_name BlocSystem


var m_levels:Array[levelInfos]
var m_currentLevel:levelInfos = null

func getEnemy(_enemyLevel:int)->Array[String]:
	return []

func getCurrentEnemies()->Array[String]:
	return m_currentLevel.m_enemies

func preloadNextEnemies():
	var nextLevel = m_currentLevel.m_nextLevel
	var enemies = m_currentLevel.m_nextLevel.m_enemies
	while enemies.is_empty() and nextLevel != null:
		enemies = nextLevel.m_enemies
		nextLevel = nextLevel.m_nextLevel

	for enemy in enemies:
		EnemyFactory.preloadEnemy(enemy)

func addLevel(_specificLevel:String="",_enemyLevel=0,_cardQuality:Globals.cardQuality = Globals.cardQuality.NONE, _dollars:int = 0):
	var level = levelInfos.new()
	if _specificLevel!="":
		level.m_lvlFile = _specificLevel
	else:
		level.m_lvlFile = Globals.m_playLevel
		
	level.m_lootCardQuality = _cardQuality
	level.m_lootDollars = _dollars
	
	if _enemyLevel != 0:
		level.m_enemies = getEnemy(_enemyLevel)
	
	if level.m_lootCardQuality != Globals.cardQuality.NONE or level.m_lootDollars !=0:
		level.m_goToLoot = true
	
	if !m_levels.is_empty():
		m_levels.back().m_nextLevel = level
	m_levels.append(level)
	if m_currentLevel == null:
		m_currentLevel = level
		

func getNextLevel() -> String:
	if m_currentLevel.m_goToLoot:
		return Globals.m_lootLevel
	else:
		m_currentLevel = m_currentLevel.m_nextLevel
		preloadNextEnemies()
		return m_currentLevel.m_lvlFile
