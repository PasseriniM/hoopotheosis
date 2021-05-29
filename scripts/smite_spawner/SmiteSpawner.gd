extends Node2D

export(bool) var active = true setget set_active
export(NodePath) var spawn_area
onready var sa = get_node(spawn_area)
export(float) var start_delay
export(float) var spawn_check_interval
export(float) var random_time_factor
export(float) var spawn_probability
#export(int) var smite_speed = 28

const MAX_SMITES = 6
const smite = preload("res://scenes/smite_spawn/Smite.tscn")
onready var hula = get_node("../Chosen/Hula")
onready var graphics = get_node("../Chosen/Graphics")

func _ready():
	if Engine.is_editor_hint(): return
	
	$SpawnTimer.start(start_delay)

func spawn():
	#print("try smite spawn")
	if can_spawn() and randf() < spawn_probability * cover_factor():
		#print("smite spawn")
		var s = smite.instance()
		$ActiveSmites.add_child(s)
		
		var lr = RandomUtils.rand_sign()
		s.speed *= -lr
		s.global_position = sa.random_global_spawn_point(lr)
	
	$SpawnTimer.start(spawn_check_interval + randf() * random_time_factor)

func can_spawn():
	var smites = $ActiveSmites.get_child_count()
	
	return smites < MAX_SMITES and smites < int(hula.active_haloops() * 1.5)

func explode_all():
	for s in $ActiveSmites.get_children():
		s.explode()

func set_active(value):
	active = value
	$SpawnTimer.paused = not value

func cover_factor():
	var u = graphics.uncover_percent()
	
	if u > 0.9:
		return 0.75
	elif u > 0.6:
		return 0.9
	elif u > 0.5:
		return 1
	elif u > 0.4:
		return 1.2
	else:
		return 1.5
