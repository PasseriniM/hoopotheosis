tool
extends Node2D

export(float) var half_range setget set_range

export(float) var start_delay
export(float) var spawn_check_interval
export(float) var random_factor
export(float) var spawn_probability
export(float) var fall_speed

const height = 100

var haloop = preload("res://scenes/Haloop.tscn")

func _ready():
	if Engine.is_editor_hint(): return
	
	#$SpawnTimer.start(start_delay)

func spawn():
	if randf() < spawn_probability:
		var h = haloop.instance()
		h.position = self.global_position
		if randi() % 2 == 0:
			pass
		else:
			pass
		
		#s.position.y += rand_range(0, self.get_parent().get_node("Graphics/Head").position.y)
		#get_parent().get_parent().get_node("Entities").add_child(s)
	
	$SpawnTimer.start(spawn_check_interval + randf() * random_factor)


func _draw():
	if not Engine.is_editor_hint(): return
	
	draw_line(Vector2(-half_range, -height),
				Vector2(half_range, -height),
				Color.blue)

func set_range(value):	
	half_range = value
	update()
