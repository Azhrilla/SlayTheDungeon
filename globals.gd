extends Node
enum visibleSide{BACK, FRONT}
enum cardTarget{ENEMY, NONE}
enum cardType{NORMAL,POWER}
enum cardPosition{DECK,HAND,DISCARD,NONE,POWER} 
enum type{HERO,MONSTER,NONE}
enum target{NONE,ALLY1,ALLY2,ALLY3,ENEMY1,ENEMY2,ENEMY3,ENEMY4}
enum cardState{DEFAULT,PLAYABLE,HOVERED}

var nextLevel = "res://Game/play_level.tscn"
var m_victoryLevel = "res://UI/victory.tscn"
var m_cards:Array[String] = ["QuickSlash","QuickSlash","QuickSlash","Slash","Slash","Grab","Grab","Defense","Defense","Defense"]


var m_lvl1:Array[String] = ["Flame","Flame","Flame"]
var m_lvl2:Array[String] = ["Caillou","Caillou","Caillou"]
var m_currentLevel = m_lvl1
