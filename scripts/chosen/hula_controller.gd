extends Node2D

export(float) var struggle_momentum
export(float) var godness_factor

const haloop = preload("res://scenes/chosen/Haloop.tscn")
onready var graphics = get_node("../Graphics")
onready var chosen = get_node("..")

var haloops = []

func _ready():
	for x in get_children():
		haloops.append(x)
		x.connect("haloop_broken", self, "_on_haloop_broken")
		x.can_break = chosen.haloops_break
	
	check_constraints()

func _process(delta):
	var ascending = count_ascending()
	
	chosen.godness += ascending * godness_factor * delta
	
	check_constraints()

func count_ascending():
	var previous = true
	var i = -1
	var count = 0
	
	while previous and i >= -haloops.size():
		previous = previous and haloops[i].is_ascending()
		if previous:
			count += 1
		
		i -= 1
	
	return count 

func check_constraints():
	for i in range(haloops.size()):
		if i == 0:
			haloops[i].min_pos = 0
		else:
			haloops[i].min_pos = haloops[i - 1].position.y - 8
		
		if i == haloops.size() - 1:
			haloops[i].max_pos = -graphics.torso_length() + 4
		else:
			haloops[i].max_pos = haloops[i + 1].position.y + 8

func struggle():
	for h in haloops:
		h.momentum += struggle_momentum * RandomUtils.rand_variance()

func drop_momentum(drop):
	for h in haloops:
		h.momentum -= drop

func set_forced_speed(fspeed):
	for h in haloops:
		h.forced_speed = fspeed

func catch_haloop():
	var h = haloop.instance()
	h.momentum = 0.5
	haloops.append(h)
	h.connect("haloop_broken", self, "_on_haloop_broken")
	self.add_child(h)
	h.position.y = -graphics.torso_length() + 4
	h.can_break = chosen.haloops_break
	check_constraints()

func active_haloops():
	return haloops.size()

func _on_haloop_broken(haloop):
	haloops.erase(haloop)

func break_all():
	for h in haloops:
		h.break_haloop()
