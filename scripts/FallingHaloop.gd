extends Node2D

export(float) var fall_speed

func _process(delta):
	translate(Vector2(0, fall_speed * delta))
	
	#if is_too_low():
	#	fade()

func is_too_low():
	var h = get_parent().get_parent().get_node("Chosen/Graphics/Head").global_position.y - 16
	
	return self.global_position.y < h

func fade():
	$Tween.interpolate_property(self, "modulate",
	Color.white, Color.transparent, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()

func _on_catch(_area):
	self.visible = false
	self.queue_free()
