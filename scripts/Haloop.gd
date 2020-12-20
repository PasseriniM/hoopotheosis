extends Node2D

export(float, 1) var momentum = 1 setget set_momentum
export(float) var decay_rate = 0.25 # mesured in momentum per second
export(float) var random_factor = 0.05

export(float) var smite_drop = 0.1

export(int) var min_pos
export(int) var max_pos

const broken = preload("res://scenes/BrokenHaloop.tscn")

func _process(delta):
	# moves the haloop up or down depending on its momentum
	var ver_speed = 64 * pow(momentum - 0.5, 5)
	translate(Vector2(0, -ver_speed * delta))
	position.y = clamp(position.y, max_pos, min_pos)
	
	# check for despawn
	if momentum <= 0:
		_break()
	
	# natural memomentum decay
	self.momentum -= (decay_rate + random_factor * rand_range(-0.5, 0.5)) * delta

func set_momentum(value):
	momentum = clamp(value, 0, 1)
	$anim_player.playback_speed = momentum

func is_ascending():
	return self.position.y <= max_pos and momentum >= 1

func _collision_w_smite(_area):
	momentum -= smite_drop

func _break():
	var b = broken.instance()
	b.global_position = self.global_position
	get_tree().get_root().add_child(b)
	self.visible = false
	self.queue_free()
