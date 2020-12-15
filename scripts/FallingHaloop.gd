extends Node2D

export(float) var fall_speed

var head = null

func _process(delta):
	translate(Vector2(0, fall_speed * delta))
	
	if is_too_low():
		fade()

func is_too_low():
	return self.global_position.y < 100

func fade():
	$Tween.interpolate_property(self, "modulate",
	Color.white, Color.transparent, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()
