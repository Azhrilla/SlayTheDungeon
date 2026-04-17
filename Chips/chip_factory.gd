class_name ChipFactory

const chipScene:PackedScene = preload("res://Chips/chip.tscn")


const chipScripts = {
	"RegenMana": preload("uid://c8dh55avtk42y"),
	"MaxMana": preload("uid://d2087jph6srtw"),
	"FirstStrike": preload("uid://dmf6cufg2sgdl"),
	"HealthPack": preload("uid://ds7gsnna5op5o"),
	"Ramp": preload("uid://bk5m24nct3qfg"),

}
static func createChip(_id:String)->Chip:
	var newChip:Chip = chipScene.instantiate()
	
	if !chipScripts.has(_id):
		push_error ("Error: the chip with name {} was not implemented".format(_id))
		return newChip

	newChip.set_script(chipScripts[_id])
	newChip.m_name = _id
	print("new chip :{chip}".format({"chip":_id}))
	return newChip
