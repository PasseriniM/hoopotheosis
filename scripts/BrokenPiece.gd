tool
extends Node2D

export(float, 0, 360) var angle setget set_angle
var dir : Vector2

func _draw():
	if not Engine.is_editor_hint(): return
	
	draw_line(Vector2.ZERO, dir * 20, Color.green)

func set_angle(value):
	angle = value
	dir = rotate_vector(Vector2(1, 0), deg2rad(angle))
	update()

func get_random_direction():
	var rangle = rand_range(-1, 1) * 30
	
	return rotate_vector(dir, deg2rad(rangle))

func rotate_vector(_vector, _angle):
	return Vector2(_vector.x * cos(_angle) - _vector.y * sin(_angle),
	_vector.x * sin(_angle) + _vector.y * cos(_angle))
