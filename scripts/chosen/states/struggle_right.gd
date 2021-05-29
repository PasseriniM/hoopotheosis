extends "res://scripts/chosen/states/struggle.gd"

func enter():
	head.play("struggle_right")
	torso.frame = 1
	.enter()

func handle_input(event):
	if event.is_action_pressed("chosen_struggle_left"):
		emit_signal("state_finished", "struggle_left")
