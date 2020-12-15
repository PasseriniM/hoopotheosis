tool
extends Node2D

export(float, 1) var godness setget set_godness
export(float) var move_speed = 24
export(float) var struggle_time = 0.5
export(float) var exhaust_time = 1
export(float) var smited_time = 2
export(float) var smited_drop = 0.2

const MIN_TORSO = 0.5
const MAX_TORSO = 14

signal godness_updated

enum {
	IDLE,
	STRUGGLE_LEFT,
	STRUGGLE_RIGHT,
	EXHAUSTED,
	SMITED,
	ACCEPT
}

var StateMove = {
	IDLE: funcref(self, "move"),
	STRUGGLE_LEFT: funcref(self, "move"),
	STRUGGLE_RIGHT: funcref(self, "move"),
	EXHAUSTED: funcref(self, "donot"),
	SMITED: funcref(self, "donot"),
	ACCEPT: funcref(self, "donot")
}

var StateUpdate = {
	IDLE: funcref(self, "idle_update"),
	STRUGGLE_LEFT: funcref(self, "sl_update"),
	STRUGGLE_RIGHT: funcref(self, "sr_update"),
	EXHAUSTED: funcref(self, "donot"),
	SMITED: funcref(self, "donot"),
	ACCEPT: funcref(self, "accept_update")
}

var state = IDLE

var smite_counter = 0

func _process(delta):
	StateMove.get(state).call_func(delta)
	StateUpdate.get(state).call_func(delta)

func _input(event):
	if event.is_action("chosen_accept"):
		if state == IDLE or state == STRUGGLE_LEFT or state == STRUGGLE_RIGHT or state == EXHAUSTED:
			enter_accept()

func idle_update(_delta):
	if Input.is_action_just_pressed("chosen_struggle_left"):
		$Graphics/Head.animation = "struggle"
		enter_struggle_left()
	if Input.is_action_just_pressed("chosen_struggle_right"):
		$Graphics/Head.animation = "struggle"
		enter_struggle_right()

func sl_update(_delta):
	if $Timers/Struggle.time_left > 0:
		if Input.is_action_just_pressed("chosen_struggle_right"):
			enter_struggle_right()

func sr_update(_delta):
	if $Timers/Struggle.time_left > 0:
		if Input.is_action_just_pressed("chosen_struggle_left"):
			enter_struggle_left()

func accept_update(_delta):
	if not Input.is_action_pressed("chosen_accept"):
		if $Timers/Exhaust.time_left > 0:
			enter_exhaust()
		else:
			enter_idle()

func enter_idle():
	$Graphics/Torso.frame = 0
	$Graphics/Head.animation = "idle"
	state = IDLE

func enter_struggle_left():
	$Graphics/Torso.frame = 2
	$Timers/Struggle.start(struggle_time)
	$Hula.struggle()
	state = STRUGGLE_LEFT

func enter_struggle_right():
	$Graphics/Torso.frame = 1
	$Timers/Struggle.start(struggle_time)
	$Hula.struggle()
	state = STRUGGLE_RIGHT

func enter_smited():
	if smite_counter == 0:
		$Graphics/Torso.frame = 0
		$Graphics/Head.animation = "smited"
		$Timers/Smited.start(smited_time)
		$Hula.drop_momentum(smited_drop)
		state = SMITED
	elif smite_counter == 1:
		$Timers/Smited.start(smited_time * 0.5 + $Timers/Smited.time_left)
		$Hula.drop_momentum(smited_drop * 0.5)
	elif smite_counter == 2:
		$Timers/Smited.start(smited_time * 0.25 + $Timers/Smited.time_left)
		$Hula.drop_momentum(smited_drop * 0.25)
	else:
		$Timers/Smited.start(smited_time * 0.1 + $Timers/Smited.time_left)
		$Hula.drop_momentum(smited_drop * 0.1)

func enter_exhaust():
	$Graphics/Head.animation = "exhausted"
	$Graphics/Torso.frame = 0
	state = EXHAUSTED

func enter_accept():
	$Graphics/Torso.frame = 0
	$Graphics/Head.animation = "accept"
	state = ACCEPT

func move(delta):
	var dir = 0
	if Input.is_action_pressed("chosen_move_left"):
		dir -= 1
	if Input.is_action_pressed("chosen_move_right"):
		dir += 1
	
	if dir != 0:
		$Graphics/Legs.animation = "moving"
		
		if dir == -1:
			$Graphics/Head.flip_h = true
		else:
			$Graphics/Head.flip_h = false
	else:
		$Graphics/Legs.animation = "idle"
	
	translate(Vector2(dir * move_speed * delta, 0))

func donot(_delta):
	pass

func set_godness(value):
	godness = value
	var torso_scale = (MAX_TORSO - MIN_TORSO) * godness + MIN_TORSO
	var head_pos = torso_scale * -16
	var torso_pos = head_pos / 2
	
	if not is_inside_tree(): yield(self, "ready")
	
	$Graphics/Torso.scale.y = torso_scale
	$Graphics/Torso.position.y = torso_pos
	
	$Graphics/Head.position.y = head_pos
	
	emit_signal("godness_updated")

func _exit_smited():
	if state == SMITED:
		smite_counter = 0
		enter_idle()

func _exit_exhausted():
	if state == EXHAUSTED:
		enter_idle()

func _exit_struggle():
	$Timers/Exhaust.start(exhaust_time)
	if state == STRUGGLE_LEFT or state == STRUGGLE_RIGHT:
		enter_exhaust()

func _smited(_area):
	enter_smited()
