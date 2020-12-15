extends Node2D

export(float) var speed

func _process(delta):
	translate(Vector2(speed * delta, 0))

func explode():
	$AnimationPlayer.play("explode")


func on_collision(_area):
	speed = 0
	explode()
