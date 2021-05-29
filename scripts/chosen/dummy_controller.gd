tool
extends Node2D

export(float, 1) var godness setget set_godness

const MIN_TORSO = 0.5
const MAX_TORSO = 13

func set_godness(value):
	godness = value
	var torso_scale = (MAX_TORSO - MIN_TORSO) * godness + MIN_TORSO
	var head_pos = torso_scale * -16
	
	$Normal/Head.position.y = head_pos
	$Normal/Torso.scale.y = torso_scale
