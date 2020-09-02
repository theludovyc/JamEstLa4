extends Node2D
class_name Plot

onready var Effect_Watered = $Effects/Sprinkled
onready var Effect_Seeded = $Effects/Sprinkled

var Garden: Node2D

var has_water: bool = false
var has_seed: bool = false


func _ready():
	Garden = get_parent()


func action_used():
	if Garden.current_action != "":
		match Garden.current_action:
			"Watering":
				watering()


func watering():
	if Garden.water > 0 && ! has_water:
		$Evaporation.start()
		Garden.water -= 1
		Effect_Watered.visible = true
		has_water = true


func evaporation():
	has_water = false
	Effect_Watered.visible = false
