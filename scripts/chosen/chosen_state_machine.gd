extends "res://scripts/idid/state_machine/state_machine.gd"

onready var idle = $Idle
onready var struggle_left = $Struggle_Left
onready var struggle_right = $Struggle_Right
onready var exhausted = $Exhausted
onready var smited = $Smited
onready var accept = $Accept
onready var catch = $Catch

func _ready():
	states_map = {
		"idle": idle,
		"struggle_left": struggle_left,
		"struggle_right": struggle_right,
		"exhausted": exhausted,
		"smited": smited,
		"accept": accept,
		"catch": catch
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name == "smited":
		if current_state == smited:
			current_state.enter()
			return
		if current_state == catch:
			return
	if state_name == "idle" and $Exhausted.exhausted:
		._change_state("exhausted")
		return
	._change_state(state_name)

func _unhandled_input(event):
	if not _active:
		return
	if event.is_action_pressed("chosen_accept"):
		if current_state in [smited, catch]:
			return
		_change_state("accept")
		return
	current_state.handle_input(event)

func _on_smited(_area):
	_change_state("smited")

func _on_catch(_area):
	_change_state("catch")
