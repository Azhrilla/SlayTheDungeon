extends Node2D
class_name TrapBase
signal trapUsed

var m_position = Globals.target.NONE


func DoWork(_target:Enemy):
	trapUsed.emit(self)
