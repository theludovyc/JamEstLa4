extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var status_string = ["Fish may come", "catch it!"]

onready var timer = $Timer

enum States{wait, catchit, catch}

var state = States.wait

var onCatch =  false

var catchTimes:int

func resetCatchTimes():
	catchTimes = randi()%3+3

#waiting fish
func resetTimer0():
	timer.start(rand_range(2, 5))
	
#waiting to catch
func resetTimer1():
	timer.start(rand_range(0.5, 1.5))

#waiting catch
func resetTimer2():
	timer.start(0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	resetCatchTimes()
	
	resetTimer0()
	pass # Replace with function body.

func reset():
	$ColorRect2.color = Color.white
			
	if onCatch:
		$ColorRect.color = Color.white
		
		onCatch = false
	
	state = States.wait
	
	resetCatchTimes()
	
	resetTimer0()
	
	print("bouuuh !")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	match state:
		States.wait:
			if !onCatch:
				$ColorRect2.color = Color.red
			else:
				$ColorRect.color = Color.yellow
			
			resetTimer2()
			
			state = States.catchit
			
		States.catchit:
			reset()
	pass # Replace with function body.


func _on_Catch_button_down():
	match state:
		States.catchit:
			if !timer.is_stopped():
				state = States.wait
				
				if !onCatch:
					onCatch = true
					
				catchTimes -= 1
				
				print(catchTimes)
				
				if catchTimes:
					$ColorRect.color = Color.red
				
					resetTimer1()
				else:
					state = States.catch
					
					print("wouhou !")
			else:
				reset()
	pass # Replace with function body.
