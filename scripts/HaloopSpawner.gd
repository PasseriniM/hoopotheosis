tool
extends Node2D

export(float) var half_range setget set_range

export(float) var start_delay
export(float) var spawn_check_interval
export(float) var random_factor
export(float) var spawn_probability
export(float) var fall_speed

const height = 100

var haloop = preload("res://scenes/FallingHaloop.tscn")

func _ready():
	if Engine.is_editor_hint(): return
	
	$SpawnTimer.start(start_delay)

func spawn():
	if randf() < get_spawn_probability():
		var h = haloop.instance()
		h.position = self.global_position
		h.position.x += rand_range(-half_range, half_range)
		h.position.y -= height
		get_parent().get_parent().get_node("Entities").add_child(h)
	
	$SpawnTimer.start(spawn_check_interval + randf() * random_factor)


func _draw():
	if not Engine.is_editor_hint(): return
	
	draw_line(Vector2(-half_range, -height),
				Vector2(half_range, -height),
				Color.blue)

func set_range(value):	
	half_range = value
	update()

func get_spawn_probability():
	return spawn_function(get_parent().get_uncover_percent())

func spawn_function(x):
	if x >= 0.8:
		return 0.9
	elif x >= 0.5:
		return (x - 0.5) / 0.3 * 0.8 + 0.1
	else:
		return 0.1
	
	
