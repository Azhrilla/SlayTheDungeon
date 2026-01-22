class_name ChipFactory



static func createChip(_id:String)->Chip:
	var newChip:Chip = null
	match _id:
		"Ramp":
			newChip = chip_ramp.new()
		"HealthPack":
			newChip = chip_healthPack.new()
		"FirstStrike":
			newChip = chip_firstStrike.new()
		"_":
			push_error ("Error: the chip with name {} was not implemented".format(_id))
			newChip = null
	print("new chip :")
	print (_id)
	return newChip
