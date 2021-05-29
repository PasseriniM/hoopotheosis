tool
extends Node2D

export(float, 1) var godness setget set_godness
export(bool) var haloops_break = true
export(float) var move_speed
export(float) var struggle_time
export(float) var exhaust_time
export(float) var smited_time
export(float) var smited_drop
export(float) var accept_drop

signal godness_updated(new_value)
# warning-ignore:unused_signal
signal haloop_caught

func set_godness(value):
	godness = value
	emit_signal("godness_updated", value)

func mute():
	$Graphics/Legs/StepAudio.stop()
	$StateMachine/Smited/SmitedAudio.stop()
