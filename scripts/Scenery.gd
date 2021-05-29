extends Node

onready var chosen = get_node("../Chosen")

func _process(_delta):
	self.position.x = int(chosen.position.x / 320) * 320
