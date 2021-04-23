extends Node2D

signal start_game

var game_started = false

func _process(delta):
	if Input.is_action_just_pressed("menu_control") and not game_started:
		print("Start Fade")
		game_started = true
		$FadeTween.interpolate_property($Panel/Fade, "self_modulate",
		Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_CIRC, Tween.EASE_IN)
		$FadeTween.start()


func _start_game():
	yield(get_tree().create_timer(1), "timeout")
	print("Game Started")
	emit_signal("start_game")
	visible = false
	queue_free()
