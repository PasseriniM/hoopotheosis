extends Node2D

export(float) var interval 
export(float) var variance

func _ready():
	$Timer.start(random_interval())

func random_interval():
	return rand_range(0, variance) + interval

func _animate():
	$Animator.play("animate")
	yield($Animator,"animation_finished")
	$Timer.start(random_interval())
