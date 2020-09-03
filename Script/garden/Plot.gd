extends Node2D
class_name Plot

onready var Effect_Watered = $Effects/Sprinkled
onready var Effect_Seeded = $Effects/Seeded
onready var Plants = $Plants

var Garden: Node2D

var has_water: bool = false
var has_seed: bool = false


func _ready():
	Garden = get_parent()
	Plants.visible = false


func action_used():
	if Garden.current_action != "":
		match Garden.current_action:
			"Watering":
				watering()
			"Planting":
				planting()


func watering():
	if Garden.water > 0 && ! has_water:
		print("Watering")
		$Evaporation.start()
		Garden.water -= 1
		Effect_Watered.visible = true
		has_water = true


func planting():
	if Garden.seed_count > 0 && Garden.seed_type != null && ! has_seed:
		print("Planting: " + Garden.seed_type.SeedName)
		for plant in Garden.Seeds:
			var plot_plant = Plants.get_node("plant")
			if plot_plant != null:
				if plant is Sprite && plant.name == Garden.seed_type.SeedName:
					plot_plant.visible = true
				plot_plant.visible = false
		Plants.visible = true
		Effect_Seeded.visible = true
		Garden.seed_count -= 1
		has_seed = true


func evaporation():
	has_water = false
	Effect_Watered.visible = false
