extends Node2D

onready var Interface = $Interface

var current_action: String = ""

var max_water: int = 15
var water: int = 10


func _ready():
	Interface.get_node("WaterLevel").max_value = max_water


func _process(_delta):
	Interface.get_node("WaterLevel").value = water


func wateringcan_mode():
	current_action = "Watering"
