tool
extends Node2D

export(float) var distance setget set_distance
export(float) var length setget set_length
export(Color) var color setget set_color
export(bool) var draw_in_game = false

func _process(_delta):
	update()

func _draw():
	if not Engine.is_editor_hint() and not draw_in_game: return
	
	draw_line(Vector2(-distance,0), Vector2(-distance, -length), color)
	draw_line(Vector2(distance,0), Vector2(distance, -length), color)

func random_global_spawn_point(direction):
	return self.global_position + Vector2(direction * distance, randf() * -length)

func set_distance(value):
	distance = value

func set_length(value):
	length = value

func set_color(value):
	color = value

func _on_godness_updated(_godness):
	length = get_node("../Graphics").torso_length()
