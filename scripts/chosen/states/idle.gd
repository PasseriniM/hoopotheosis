extends "res://scripts/chosen/states/moving.gd"

func enter():
	head.play("idle")
	torso.frame = 0

func handle_input(event):
	if event.is_action_pressed("chosen_struggle_left"):
		emit_signal("state_finished", "struggle_left")
	if event.is_action_pressed("chosen_struggle_right"):
		emit_signal("state_finished", "struggle_right")
