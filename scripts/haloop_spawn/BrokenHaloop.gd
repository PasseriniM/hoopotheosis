extends Node2D

export(float) var animation_time

func _ready():
	_break()

func _break():
	var t = $BreakingTween
	randomize()
	
	# Fading animation
	t.interpolate_property($"piece 1", "modulate", 
	Color(1,1,1,1), Color(1,1,1,0), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 2", "modulate", 
	Color(1,1,1,1), Color(1,1,1,0), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 3", "modulate", 
	Color(1,1,1,1), Color(1,1,1,0), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 4", "modulate", 
	Color(1,1,1,1), Color(1,1,1,0), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 5", "modulate", 
	Color(1,1,1,1), Color(1,1,1,0), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	# Random rotation
	t.interpolate_property($"piece 1", "rotation_degrees",
	0, random_angle(), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 2", "rotation_degrees",
	0, random_angle(), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 3", "rotation_degrees",
	0, random_angle(), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 4", "rotation_degrees",
	0, random_angle(), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 5", "rotation_degrees",
	0, random_angle(), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	t.interpolate_property($"piece 1", "position",
	$"piece 1".position, $"piece 1".position + random_move($"piece 1"), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 2", "position",
	$"piece 2".position, $"piece 2".position + random_move($"piece 2"), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 3", "position",
	$"piece 3".position, $"piece 3".position + random_move($"piece 3"), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 4", "position",
	$"piece 4".position, $"piece 4".position + random_move($"piece 4"), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.interpolate_property($"piece 5", "position",
	$"piece 5".position, $"piece 5".position + random_move($"piece 5"), animation_time,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	t.start()

func random_angle():
	return (randf() - 0.5) * 360

func random_move(piece):
	var rspeed = randf() * 32 + 32
	return piece.get_random_direction() * rspeed
