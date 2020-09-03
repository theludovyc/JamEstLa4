extends Control

onready var Animations = $Animations

var Garden


func _ready():
	Garden = self.get_parent().get_parent()
	get_node("Inner_box").get_node("Inner").get_node("Carrot").disabled = true


func open():
	Animations.play("open")


func close():
	Animations.play("close")


func set_current_seed():
	var seed_name = ""
	for b in get_node("Inner_box").get_node("Inner").get_children():
		b.disabled = false
		if b.is_hovered():
			seed_name = b.name
			b.disabled = true

	for s in Garden.Seeds:
		if s.SeedName == seed_name:
			Garden.seed_type = s
