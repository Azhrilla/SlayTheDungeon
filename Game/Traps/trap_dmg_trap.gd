extends TrapBase
class_name Trap_DmgTrap
var m_dmg = 0

func DoWork(_target:Enemy):
	if _target.m_currentPosition != m_position:
		push_error("Trap triggered while the monster is not on the correct position")

	_target.takeDmg(m_dmg,null)
	super.DoWork(_target)
	queue_free()
