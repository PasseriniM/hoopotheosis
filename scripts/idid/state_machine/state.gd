extends Node

# warning-ignore:unused_signal
signal state_entered(current_state_name)
# warning-ignore:unused_signal
signal state_finished(next_state_name)


func enter():
	pass


func exit():
	pass


func handle_input(_event):
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func _on_animation_finished(_anim_name):
	pass
