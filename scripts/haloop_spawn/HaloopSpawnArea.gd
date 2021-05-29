tool
extends Node2D

export(float) var half_width setget set_half_width
export(float) var half_height setget set_half_height
export(Color) var color setget set_color
export(bool) var draw_in_game = false

var rect

func _process(_delta):
	update()

func _draw():
	if not Engine.is_editor_hint() and not draw_in_game: return
	
	draw_rect(rect, color, false)
	#draw_circle(rect.position, 1, Color.green)

func get_random_point():
	return rect.position + Vector2(randf() * rect.size.x, randf() * rect.size.y)

func recalculate():
	rect = Rect2(-Vector2(half_width, half_height), Vector2(half_width*2, half_height*2))
	#print(rect)

func set_half_width(value):
	half_width = value
	recalculate()

func set_half_height(value):
	half_height = value
	recalculate()

func set_color(value):
	color = value
