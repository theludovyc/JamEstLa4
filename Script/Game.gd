extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entity:Entity

var food = preload("res://Item/Brownie.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	entity = $Entity
	
	entity.hunger = 50
	
	$HungerBar.value = $Entity.hunger
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GiveFood_pressed():
	if(entity.hunger != entity.MAX):
		entity.hunger = clamp(entity.hunger + food.hunger_restored, 0, entity.MAX)
	
		$HungerBar.value = $Entity.hunger
	pass # Replace with function body.
