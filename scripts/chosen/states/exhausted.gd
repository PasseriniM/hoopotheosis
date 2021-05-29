extends "res://scripts/chosen/states/chosen_state.gd"

var exhausted = false

func enter():
	head.play("exhausted")
	torso.frame = 0
	legs.play("idle")
	
	if not exhausted:
		exhausted = true
		$Timer.start(chosen.exhaust_time)

func update(_delta):
	if not exhausted:
		emit_signal("state_finished", "idle")

func _on_Timer_timeout():
	exhausted = false
