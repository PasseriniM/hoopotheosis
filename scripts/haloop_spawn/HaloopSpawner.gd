extends Node2D

export(bool) var active = true setget set_active
export(NodePath) var spawn_area
onready var sa = get_node(spawn_area)
export(float) var start_delay
export(float) var spawn_check_interval
export(float) var catch_interval
export(float) var random_factor
export(float) var spawn_probability

var haloop = preload("res://scenes/haloop_spawn/FallingHaloop.tscn")
onready var hula = get_node("../Chosen/Hula")
onready var graphics = get_node("../Chosen/Graphics")

const MAX_HALOOPS = 5

func _ready():	
	$SpawnTimer.start(start_delay)

func spawn():
	if can_spawn() and randf() < pow(spawn_probability, hula.active_haloops()):
		print("haloop spawn")
		var h = haloop.instance()
		$FallingHaloops.add_child(h)
		h.global_position = sa.global_position + sa.get_random_point()
	
	$SpawnTimer.start(spawn_check_interval + randf() * random_factor)

func can_spawn():
	return active and hula.active_haloops() < MAX_HALOOPS and graphics.torso_length() > (hula.active_haloops() + 1) * 8 and $FallingHaloops.get_child_count() < 1

func set_active(value):
	active = value
	$SpawnTimer.paused = not value

func fade_all():
	for h in $FallingHaloops.get_children():
		h.fade()

func after_catch_pause():
	$SpawnTimer.start(catch_interval + randf() * random_factor)
