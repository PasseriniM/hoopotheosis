tool
extends Node2D

export(int) var distance setget set_distance

export(float) var start_delay
export(float) var spawn_check_interval
export(float) var random_factor
export(float) var spawn_probability
export(int) var smite_speed = 28

var smite = preload("res://scenes/Smite.tscn")

func _ready():
	if Engine.is_editor_hint(): return
	
	$SpawnTimer.start(start_delay)

func spawn():
	if randf() < spawn_probability:
		var s = smite.instance()
		s.position = self.global_position
		if randi() % 2 == 0:
			s.position.x += distance
			s.speed = -smite_speed
		else:
			s.position.x -= distance
			s.speed = smite_speed
		
		s.position.y += rand_range(0, self.get_parent().get_node("Graphics/Head").position.y)
		get_parent().get_parent().get_node("Entities").add_child(s)
	
	$SpawnTimer.start(spawn_check_interval + randf() * random_factor)


func _draw():
	if not Engine.is_editor_hint(): return
	
	var l = self.get_parent().get_node("Graphics/Head").position.y
	
	draw_line(Vector2(distance, 0),
				Vector2(distance, l),
				Color(255, 0, 0))
	
	draw_line(Vector2(-distance, 0),
				Vector2(-distance, l),
				Color(255, 0, 0))

func set_distance(value):	
	distance = value
	update()


func _on_Chosen_godness_updated():
	update()
