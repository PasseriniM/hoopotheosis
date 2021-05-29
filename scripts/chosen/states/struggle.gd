extends "res://scripts/chosen/states/moving.gd"

var timer

func enter():
	timer = 0
	hula.struggle()

func update(delta):
	.update(delta)
	timer += delta
	
	if timer >= chosen.struggle_time:
		emit_signal("state_finished", "exhausted")
