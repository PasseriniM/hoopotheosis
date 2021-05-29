extends Node2D

export(float) var fall_speed

var fading = false

signal haloop_missed
signal haloop_caught

func _process(delta):
	translate(Vector2(0, fall_speed * delta))
	
	if is_too_low():
		emit_signal("haloop_missed")
		fade()

func is_too_low():
	return self.position.y >= 0 and not fading

func fade():
	fading = true
	$Tween.interpolate_property(self, "modulate",
	Color.white, Color.transparent, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$FallingAudio.stop()
	$Tween.start()

func _on_catch(_area):
	self.visible = false
	emit_signal("haloop_caught")
	self.queue_free()
