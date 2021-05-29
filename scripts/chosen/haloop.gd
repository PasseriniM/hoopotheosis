extends Node2D

signal haloop_broken(haloop)

export(float, 1) var momentum setget set_momentum
export(float) var decay_rate # mesured in momentum per second
export(float) var random_factor
export(float) var smite_drop

var min_pos: int
var max_pos: int
var can_break: bool
var forced_speed = 0

const broken = preload("res://scenes/chosen/BrokenHaloop.tscn")
const upspeed = 9
const gravity = upspeed * 2 / 3

func _ready():
	set_momentum(momentum)

func _process(delta):
	# moves the haloop up or down depending on its momentum
	var ver_speed = upspeed * pow(momentum, 4) - gravity + forced_speed
	translate(Vector2(0, -ver_speed * delta))
	position.y = clamp(position.y, max_pos, min_pos)
	
	# check for despawn
	if can_break and momentum <= 0 and position.y >= 0:
		break_haloop()
	
	# natural memomentum decay
	self.momentum -= (decay_rate + random_factor * rand_range(-0.5, 0.5)) * delta
	$HulaAnimator.playback_speed = momentum

func set_momentum(value):
	momentum = clamp(value, 0, 1)

func is_ascending():
	return momentum >= 0.95 and self.position.y <= max_pos + 1

func break_haloop():
	var b = broken.instance()
	b.global_position = self.global_position
	get_tree().get_root().add_child(b)
	self.visible = false
	emit_signal("haloop_broken", self)
	self.queue_free()

func _on_smite_collision(_area):
	momentum -= smite_drop
