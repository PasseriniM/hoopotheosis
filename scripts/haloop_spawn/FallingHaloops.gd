tool
extends Node2D

export(bool) var draw_in_game = false

func _process(_delta):
	update()

func _draw():
	if not Engine.is_editor_hint() and not draw_in_game: return
	
	draw_line(Vector2(-500, 0), Vector2(500, 0), Color.red)

func _on_godness_updated(_godness):
	self.global_position.y = get_node("../../Chosen/Graphics/Head").global_position.y - 14
