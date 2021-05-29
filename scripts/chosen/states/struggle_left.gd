extends "res://scripts/chosen/states/struggle.gd"

func enter():
	head.play("struggle_left")
	torso.frame = 2
	.enter()

func handle_input(event):
	if event.is_action_pressed("chosen_struggle_right"):
		emit_signal("state_finished", "struggle_right")
