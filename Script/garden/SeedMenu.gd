extends Control

onready var Animations = $Animations


func open():
	Animations.play("open")


func close():
	Animations.play("close")
