extends Node2D

# Exports
export (int, 1, 99999999) var EvaporationTime = 600
export (Array) var Seeds = []

# Nodes
onready var Interface = $Interface
onready var SeedMenu = $Interface/SeedMenu
# Actions
var current_action: String = ""

# Watering
var max_water: int = 50
var water: int = 50 setget set_water

# Planting
var seed_type
var seed_max = 50
var seed_count = 50 setget set_seed_count


func _ready():
	for child in get_children():
		if child is Plot:
			child.get_node("Evaporation").wait_time = EvaporationTime
	update_water_bar()
	update_seed_bar()


func set_water(value):
	water = value
	update_water_bar()


func set_seed_count(value):
	seed_count = value
	update_seed_bar()


func update_water_bar():
	Interface.get_node("Watering").get_node("WaterLevel").max_value = max_water
	Interface.get_node("Watering").get_node("WaterLevel").value = water
	Interface.get_node("Watering").get_node("Stat").text = str(water) + "/" + str(max_water)


func update_seed_bar():
	Interface.get_node("Planting").get_node("SeedsLevel").max_value = seed_count
	Interface.get_node("Planting").get_node("SeedsLevel").value = seed_count
	Interface.get_node("Planting").get_node("Stat").text = str(seed_count) + "/" + str(seed_max)


# On click watering can
func wateringcan_mode():
	toggle_curent_action("Watering")


# On click plantation
func seed_select():
	seed_type = Seeds[0]  # Temporary seed for test
	toggle_curent_action("Planting")


# Actions manager
func toggle_curent_action(action: String = ""):
	if current_action == action:
		action = ""
	current_action = action
	for child in Interface.get_children():
		if child.has_node("Selected"):
			child.get_node("Selected").visible = false
	if action != "":
		Interface.get_node(action).get_node("Selected").visible = true


# Open the menu
func open_menu():
	SeedMenu.open()
