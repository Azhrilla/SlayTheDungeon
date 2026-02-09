extends BlocSystem
class_name Act1_Bloc1

func getEnemy(_enemyLevel:int)->Array[String]:
	match _enemyLevel:
		1:
			var rng = RandomNumberGenerator.new()
			var currentRNG = rng.randf_range(0.0, 1.0)
			if currentRNG > 0.5:
				return ["Drone","Drone","Drone"]
			else:
				return ["Flame","Flame"]
		2:
			return ["Drone","Drone","Drone","Drone"]
		3: 
			var rng = RandomNumberGenerator.new()
			var currentRNG = rng.randf_range(0.0, 1.0)
			if currentRNG > 0.5:
				return ["Caillou","Caillou"]
			else:
				return ["Flame","Flame","Flame"]
		5: 
			return ["Drone","Grorobo","Drone"]
		_:
			push_error("Trying to create a non referenced enemy")
			return []
			
func _init():
	addLevel()
	addLevel("res://Interludes/act_1_bloc_1_scene_1.tscn")
	addLevel("res://Interludes/act_1_bloc_1_scene_2.tscn")
	addLevel("",1,Globals.cardQuality.NORMAL,50)
	addLevel("",1,Globals.cardQuality.NORMAL,50)
	addLevel("",2,Globals.cardQuality.NORMAL,50)
	addLevel("res://Interludes/act_1_bloc_1_scene_3.tscn")
	addLevel("",3,Globals.cardQuality.NORMAL,50)
	addLevel("",3,Globals.cardQuality.NORMAL,50)
	addLevel("",5,Globals.cardQuality.NORMAL,100)
	addLevel(Globals.m_victoryLevel)
	
