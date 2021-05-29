extends "res://scripts/chosen/states/chosen_state.gd"

var smite_counter = 0
var smite_timer = 0

func enter():
	match smite_counter:
		0:
			head.play("smited")
			torso.frame = 0
			legs.play("idle")
			$SmitedAudio.play()
			smite_timer = chosen.smited_time
		1:
			smite_timer += chosen.smited_time * 0.5
		2:
			smite_timer += chosen.smited_time * 0.25
		_:
			smite_timer += chosen.smited_time * 0.1
	
	smite_counter += 1

func update(delta):
	smite_timer -= delta
	
	if smite_timer <= 0:
		emit_signal("state_finished", "idle")

func exit():
	smite_counter = 0
	$SmitedAudio.stop()
