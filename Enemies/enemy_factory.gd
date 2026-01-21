class_name EnemyFactory


const caillou:PackedScene = preload("res://Enemies/enemy_caillou.tscn")
const flame:PackedScene = preload("res://Enemies/enemy_flame.tscn")
const sniper:PackedScene = preload("res://Enemies/enemy_sniper.tscn")



static func createEnemy(_id:String)->Enemy:
	var newEnemy:Enemy = null
	match _id:
		"Flame":
			newEnemy = flame.instantiate()
		"Caillou":
			newEnemy = caillou.instantiate()
		"Sniper":
			newEnemy = sniper.instantiate()
		"_":
			push_error ("Error: the enemy with name {} was not implemented".format(_id))
			newEnemy = null
	return newEnemy
