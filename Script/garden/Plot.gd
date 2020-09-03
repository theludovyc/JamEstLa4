extends Node2D
class_name Plot

# Plot effects
onready var Effect_Watered = $Effects/Sprinkled
onready var Effect_Seeded = $Effects/Seeded

# List of plantations
onready var Plants = $Plants

# Growing timer / speed
onready var Growing = $Growing

# Garden
var Garden: Node2D

# Current plantation sprite
var PlantSprite: Sprite

# Informations
var has_water: bool = false
var has_seed: bool = false
var grow_time: int = 0
var grow_modifier: float = 1.0
var is_harvestable: bool = false


func _ready():
	Garden = get_parent()
	Plants.visible = false
	randomize_grow_modifier()


func _process(_delta):
	if Growing.is_stopped() && has_seed:
		Growing.start()
	if has_water:
		Growing.wait_time = 0.75 * grow_modifier
	else:
		Growing.wait_time = 1 * grow_modifier


func randomize_grow_modifier():
	grow_modifier = rand_range(0.8, 1.2)


# On click on plot
func action_used():
	if Garden.current_action != "":
		match Garden.current_action:
			"Watering":
				watering()
			"Planting":
				planting()


# When timer Growing is ended
func growing():
	if grow_time < Garden.seed_type.GrowDuration:
		grow_time += 1
		time_changed()
		randomize_grow_modifier()
	else:
		is_harvestable = true


# Check for growing stade
func time_changed():
	var grow_duration = Garden.seed_type.GrowDuration
	var grow_steps = Garden.seed_type.GrowSteps

	var step = grow_duration / grow_steps
	var current_stade = floor(grow_time / step)
	change_stade_to(current_stade)


# Define the current sprite
func change_stade_to(current_stade):
	if PlantSprite != null:
		current_stade -= 1
		var sprite_size: Vector2 = PlantSprite.region_rect.size
		PlantSprite.region_rect.position = Vector2(sprite_size.x * current_stade, 0)


# Watering the plot
func watering():
	if Garden.water > 0 && ! has_water:
		$Evaporation.start()
		Garden.water -= 1
		Effect_Watered.visible = true
		has_water = true


# Planting seed in plot
func planting():
	if Garden.seed_count > 0 && Garden.seed_type != null && ! has_seed:
		for plant in Plants.get_children():
			plant.visible = false
		for plant in Garden.Seeds:
			if Plants.find_node(plant.SeedName):
				var plant_node = Plants.get_node(plant.SeedName)
				if plant_node != null:
					if plant.SeedName == Garden.seed_type.SeedName:
						PlantSprite = plant_node
						PlantSprite.visible = true
		Plants.visible = true
		Effect_Seeded.visible = true
		Garden.seed_count -= 1
		has_seed = true
		change_stade_to(0)


# End of timer Evaporation
func evaporation():
	has_water = false
	Effect_Watered.visible = false
