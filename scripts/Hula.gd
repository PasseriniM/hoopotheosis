extends Node2D

export var struggle_momentum = 0.05
export var godness_factor = 0.3

var haloops = []

func _ready():
	for x in get_children():
		haloops.append(x)
	
	for h in haloops:
		h.hula = true
	
	check_constraints()

func _process(delta):
	var ascending = 0
	
	for h in haloops:
		if h.is_ascending():
			ascending += 1
	
	get_parent().godness += ascending * godness_factor * delta
	
	check_constraints()

func check_constraints():
	for i in range(haloops.size()):
		if i == 0:
			haloops[i].min_pos = 0
		else:
			haloops[i].min_pos = haloops[i - 1].position.y - 8
		
		if i == haloops.size() - 1:
			haloops[i].max_pos = get_parent().get_node("Graphics/Head").position.y
		else:
			haloops[i].max_pos = haloops[i + 1].position.y + 8

func struggle():
	for h in haloops:
		h.momentum += struggle_momentum

func drop_momentum(drop):
	for h in haloops:
		h.momentum -= drop