extends TileMap

var chosen

func _ready():
	chosen = get_parent().get_node("Chosen")

func _process(delta):
	var p = int(chosen.position.x)
	
	self.position.x = (p % 320) * 320
