extends BlocSystem
class_name Act1_Bloc1

func getEnemy(_enemyLevel:int)->Array[String]:
	match _enemyLevel:
		1:
			var currentRNG = getRngNumber()
			if currentRNG > 0.5:
				return ["Drone","Drone","Drone"]
			else:
				return ["GiantRat","GiantRat"]
		2:
			var currentRNG = getRngNumber()
			if currentRNG > 0.5:
				return ["Drone","Drone","Drone","Drone"]
			else:
				return ["GiantRat","GiantRat","GiantRat"]
		3: 
			var currentRNG = getRngNumber()
			if currentRNG > 0.5:
				return ["Caillou","Caillou"]
			else:
				return ["Enforcer","Enforcer","Enforcer"]
		5: 
			return ["Drone","Grorobo","Drone"]
		_:
			push_error("Trying to create a non referenced enemy")
			return []
			
func _init():
	addLevel()
	if Globals.m_godMode:
		addLevel("res://UI/Armory.tscn")
	addLevel("res://Interludes/act_1_bloc_1_scene_1.tscn")
	addLevel("res://Interludes/act_1_bloc_1_scene_2.tscn")
	addLevel("",1,Globals.cardQuality.NORMAL,50)
	addLevel("",1,Globals.cardQuality.NORMAL,50)
	addLevel("",2,Globals.cardQuality.NORMAL,50)
	addLevel("res://Interludes/act_1_bloc_1_scene_3.tscn")
	addLevel("res://Interludes/act_1_bloc_1_scene_4.tscn")
	addLevel("",3,Globals.cardQuality.NORMAL,50)
	addLevel("",3,Globals.cardQuality.NORMAL,50)
	addLevel("res://Interludes/act_1_bloc_1_scene_5.tscn")
	addLevel("",5,Globals.cardQuality.NORMAL,100)
	addLevel("res://Interludes/act_1_bloc_1_scene_6.tscn")
	addLevel("res://UI/Armory.tscn")
	addLevel("",3,Globals.cardQuality.NORMAL,50)
	addLevel("",3,Globals.cardQuality.NORMAL,50)
	addLevel(Globals.m_victoryLevel)
	
