extends Node2D

export (int, 1, 99999999) var EvaporationTime = 600
export (Array) var Seeds = []

onready var Interface = $Interface

var plot_obj = preload("res://Scene/garden/Plot.tscn")

var current_action: String = ""

var max_water: int = 50
var water: int = 50

var seed_type
var seed_max = 50
var seed_count = 15


func _ready():
	Interface.get_node("Watering").get_node("WaterLevel").max_value = max_water
	for child in get_children():
		if child is Plot:
			child.get_node("Evaporation").wait_time = EvaporationTime


func _process(_delta):
	Interface.get_node("Watering").get_node("WaterLevel").value = water
	Interface.get_node("Watering").get_node("Stat").text = str(water) + "/" + str(max_water)
	Interface.get_node("Planting").get_node("SeedsLevel").value = seed_count
	Interface.get_node("Planting").get_node("Stat").text = str(seed_count) + "/" + str(seed_max)


func wateringcan_mode():
	toggle_curent_action("Watering")


func seed_select():
	seed_type = Seeds[0]  # Temporary seed for test
	toggle_curent_action("Planting")


func toggle_curent_action(action: String = ""):
	if current_action == action:
		action = ""
	current_action = action
	for child in Interface.get_children():
		if child.has_node("Selected"):
			child.get_node("Selected").visible = false
	if action != "":
		Interface.get_node(action).get_node("Selected").visible = true
