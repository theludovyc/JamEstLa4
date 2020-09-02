extends Node

var entity: Entity

var food = preload("res://Item/Brownie.tres")

var action = preload("res://Action/Gardening.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	entity = $Entity

	entity.hunger = 50

	entity.fatigue = 50

	$HungerBar.value = entity.hunger

	$FatigueBar.value = entity.fatigue


func _on_SelectFood_button_down():
	pass  # Replace with function body.


func _on_GiveFood_pressed():
	if entity.hunger != entity.MAX:
		entity.hunger = clamp(entity.hunger + food.action.hunger_cost, 0, entity.MAX)

		entity.fatigue = clamp(entity.fatigue + food.action.fatigue_cost, 0, entity.MAX)

		$HungerBar.value = entity.hunger

		$FatigueBar.value = entity.fatigue
	pass  # Replace with function body.


func _on_MakeAction_button_down():
	if entity.fatigue >= action.fatigue_cost:
		entity.fatigue -= action.fatigue_cost

		$FatigueBar.value = entity.fatigue
	pass  # Replace with function body.
