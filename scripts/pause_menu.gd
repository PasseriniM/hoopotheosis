extends Node2D

var paused = false

func _unhandled_input(event):
	if event.is_action_pressed("game_pause"):
		paused = not paused
		get_tree().paused = paused
		self.visible = paused
