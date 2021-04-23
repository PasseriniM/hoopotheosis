extends Node2D

signal smite_exploded

export(float) var speed

func _process(delta):
	translate(Vector2(speed * delta, 0))

func explode():
	speed = 0
	$AnimationPlayer.play("explode")
	emit_signal("smite_exploded")


func on_collision(_area):
	explode()
