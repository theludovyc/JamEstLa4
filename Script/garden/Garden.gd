extends Node2D

# Exports
export (int, 1, 99999999) var EvaporationTime = 600
export (Array) var Seeds = []

# Nodes
onready var Interface = $Interface
onready var SeedMenu = $Interface/SeedMenu
onready var FillBar = $Interface/Watering/FillBar
onready var FillIcon = $Interface/Watering/FillIcon
onready var FillTimer = $Interface/Watering/FillTimer

# Actions
var current_action: String = ""

# Watering
var max_water: int = 50
var water: int = 50 setget set_water
var can_fill: bool = false

# Planting
var seed_type = load("res://Item/seeds/Carrot.tres") setget seed_type_changed
var seed_max = 50
var seed_count = 50 setget set_seed_count
var inventory_seed_count = {
	"Carrot": 50, "Eggplant": 15, "Tomato": 25, "Laittuce": 14, "Turnip": 43
}


func _ready():
	for child in get_children():
		if child is Plot:
			child.get_node("Evaporation").wait_time = EvaporationTime
	Interface.get_node("Planting").get_node("SeedsLevel").max_value = seed_max
	FillBar.hide()
	FillIcon.hide()
	update_water_bar()
	update_seed_bar()


func set_water(value):
	water = value
	if water <= 0:
		FillBar.max_value = max_water
		FillBar.value = water
		FillBar.show()
		FillIcon.show()
		current_action = ""
	else:
		FillBar.hide()
		FillIcon.hide()
	update_water_bar()


func set_seed_count(value):
	seed_count = value
	update_seed_bar()


func seed_type_changed(value):
	$Interface/Planting/Sprite.texture = value.VegetableSprite
	inventory_seed_count[seed_type.SeedName] = seed_count
	seed_count = inventory_seed_count[value.SeedName]
	seed_type = value
	updateBars()


func updateBars():
	update_water_bar()
	update_seed_bar()


func update_water_bar():
	Interface.get_node("Watering").get_node("WaterLevel").max_value = max_water
	Interface.get_node("Watering").get_node("WaterLevel").value = water
	Interface.get_node("Watering").get_node("Stat").text = str(water) + "/" + str(max_water)


func update_seed_bar():
	Interface.get_node("Planting").get_node("SeedsLevel").value = seed_count
	Interface.get_node("Planting").get_node("Stat").text = str(seed_count) + "/" + str(seed_max)


# On click watering can
func wateringcan_mode():
	if ! can_fill:
		toggle_curent_action("Watering")


# On click plantation
func seed_select():
	toggle_curent_action("Planting")


# Actions manager
func toggle_curent_action(action: String = ""):
	if current_action == action:
		action = ""
	current_action = action
	print(current_action)
	for child in Interface.get_children():
		if child.has_node("Selected"):
			child.get_node("Selected").visible = false
	if action != "":
		Interface.get_node(action).get_node("Selected").visible = true


# Open the menu
func open_menu():
	SeedMenu.open()


# Enter fill_btn
func on_fill():
	FillIcon.rect_scale = Vector2.ONE * 1.2
	can_fill = true


# Exit fill_btn
func out_fill():
	FillIcon.rect_scale = Vector2.ONE
	can_fill = true


# Press fill_btn
func press_fill():
	if FillTimer.is_stopped():
		FillTimer.start()


# Stop press fill_btn
func stop_press_fill():
	if ! FillTimer.is_stopped():
		FillTimer.stop()
	if water >= 1:
		can_fill = false
		FillIcon.hide()
		FillBar.hide()
		FillTimer.stop()
		FillIcon.rect_scale = Vector2.ONE
		toggle_curent_action("Watering")
		update_water_bar()


# Timer filling water
func filling():
	if water < max_water:
		water += 1
		FillBar.max_value = max_water
		FillBar.value = water
		if water == max_water:
			can_fill = false
			FillIcon.hide()
			FillIcon.rect_scale = Vector2.ONE
			FillBar.hide()
			FillBar.value = 0
			update_water_bar()
