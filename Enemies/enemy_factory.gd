class_name EnemyFactory

const enemyScenes: Dictionary[String,String] ={
		"Flame":"uid://gumnk56wfijl",
		"Caillou":"uid://dakepv5v8j14s",
		"Sniper":"uid://dtlrlbygskqkc",
		"Drone":"uid://bc74efqmpracj",
		"Grorobo":"uid://cw1yfid7378h4",
		"GiantRat":"uid://cr5avcpls14rh",
	}

static var m_resources = {}

static func statusLoading():
	for enemy in m_resources:
		
		var uid = EnemyFactory.enemyScenes[enemy]
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(EnemyFactory.enemyScenes[enemy], progress)
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED and m_resources[enemy] == null:
			
			var newScene:PackedScene = ResourceLoader.load_threaded_get(uid)
			m_resources[enemy] = newScene
			print ("Finished loading {enemy} with uid :{uid} ".format({"enemy":enemy,"uid":uid}))
		#elif status != ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			#print ("Preloading status {status} : {enemy} with uid :{uid} progress : {prog}".format({"status":status,"enemy":enemy,"uid":uid,"prog":progress[0]*100}))
		

static func preloadEnemy(_id:String):
	if m_resources.has(_id):
		return
	
	var uid = EnemyFactory.enemyScenes[_id]
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(EnemyFactory.enemyScenes[_id], progress)
	if status !=ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS and status != ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		print ("Preloading enemy : {enemy} with uid :{uid}".format({"enemy":_id,"uid":uid}))
		ResourceLoader.load_threaded_request(uid)
		m_resources[_id] = null
	
static func createEnemy(_id:String)->Enemy:
	var newEnemy:Enemy = null
	
	var uidOfEnemyScene = enemyScenes[_id]
	if uidOfEnemyScene == null:
		push_error ("Error: the enemy with name {} was not implemented".format(_id))
		newEnemy = null
		return newEnemy
	
	newEnemy = m_resources[_id].instantiate()

	return newEnemy
