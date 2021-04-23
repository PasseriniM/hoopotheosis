extends Node2D

func _show_intro():
	$Intro.visible = true
	#$Intro/Animator.playback_speed = 5
	$Intro/Animator.play("mount_hulympus")
