extends "res://scripts/chosen/states/chosen_state.gd"

export(float) var forced_speed

onready var humpf = get_node("../../Graphics/Head/HumpfAudio")
onready var collision = get_node("../../Graphics/Head/Area2D/CollisionShape2D")

func enter():
	head.play("accept")
	torso.frame = 0
	legs.play("idle")
	humpf.play()
	collision.disabled = false
	hula.set_forced_speed(forced_speed)

func handle_input(event):
	if event.is_action_released("chosen_accept"):
		collision.disabled = true
		emit_signal("state_finished", "idle")

func exit():
	hula.set_forced_speed(0)
