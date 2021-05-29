extends "res://scripts/chosen/states/chosen_state.gd"

func enter():
	chosen.emit_signal("haloop_caught")	
	head.play("catch")
	torso.frame = 0
	legs.play("idle")

func _on_animation_finished(_anim_name):
	emit_signal("state_finished", "idle")
	hula.catch_haloop()
