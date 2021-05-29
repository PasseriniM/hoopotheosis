extends "res://scripts/chosen/states/chosen_state.gd"

onready var head_sprite = get_node("../../Graphics/Head")

var dir

func update(delta):
	dir = 0
	if Input.is_action_pressed("chosen_move_left"):
		dir -= 1
	if Input.is_action_pressed("chosen_move_right"):
		dir += 1
	
	if dir != 0:
		legs.play("move")
	
		match dir:
			-1:
				head_sprite.flip_h = true
			1:
				head_sprite.flip_h = false
		
		chosen.translate(Vector2(dir * chosen.move_speed * delta, 0))
	else:
		legs.play("idle")
	
