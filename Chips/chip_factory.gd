class_name ChipFactory

const chipScene:PackedScene = preload("res://Chips/chip.tscn")


const firstStrike = preload("res://Chips/chip_firstStrike.gd")
const healthPack = preload("res://Chips/chip_healthPack.gd")
const ramp = preload("res://Chips/chip_ramp.gd")



static func createChip(_id:String)->Chip:
	var newChip:Chip = chipScene.instantiate()
	match _id:
		"Ramp":
			newChip.set_script(ramp)
		"HealthPack":
			newChip.set_script(healthPack)
		"FirstStrike":
			newChip.set_script(firstStrike)
		"_":
			push_error ("Error: the chip with name {} was not implemented".format(_id))
			newChip = null
	print("new chip :")
	print (_id)
	UIGlobal.addChip(newChip)
	return newChip
