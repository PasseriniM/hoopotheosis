tool
extends Node2D

const MIN_TORSO = 0.5
const MAX_TORSO = 13
onready var hula = get_node("../Hula")

func _on_godness_updated(godness):
	var torso_scale = (MAX_TORSO - MIN_TORSO) * godness + MIN_TORSO
	var head_pos = torso_scale * -16
	
	$Head.position.y = head_pos
	$Torso.scale.y = torso_scale

func torso_length():
	return int($Torso.scale.y * 16)

func torso_covered():
	return hula.active_haloops() * 8

func torso_uncovered():
	return torso_length() - torso_covered()

func cover_percent():
	return torso_length() / torso_covered()

func uncover_percent():
	return 1 - cover_percent()
