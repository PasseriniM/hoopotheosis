extends Node

export(bool) var active

func _ready():
	set_process_unhandled_input(active)

func _unhandled_input(event):
	if event.is_action_pressed("debug_lose"):
		get_parent().play_lose()
	
	if event.is_action_pressed("debug_win"):
		get_parent().play_win()

