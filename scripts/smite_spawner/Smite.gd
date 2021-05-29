extends Node2D

export(float) var speed

func _process(delta):
	translate(Vector2(speed * delta, 0))

func explode():
	speed = 0
	$AnimationPlayer.play("explode")


func on_collision(_area):
	explode()
