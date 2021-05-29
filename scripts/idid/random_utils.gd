extends Node

const MIN_VARIANCE = 0.8
const MAX_VARIANCE = 1.2

func rand_sign():
	return (randi() % 2) * 2 -1

func rand_variance():
	return (MAX_VARIANCE - MIN_VARIANCE) * randf() + MIN_VARIANCE
