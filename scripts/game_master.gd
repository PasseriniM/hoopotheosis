extends Node

# warning-ignore:unused_signal
signal game_win
# warning-ignore:unused_signal
signal game_loss

export(bool) var do_checks = true

onready var chosen = $Chosen
onready var hula = $Chosen/Hula

func _process(_delta):
	if do_checks:
		if win_check():
			play_win()
		if lose_check():
			play_lose()

func win_check():
	return chosen.godness >= 1

func lose_check():
	return hula.active_haloops() == 0

func play_win():
	print("Game win")
	do_checks = false
	$Chosen/Graphics/Legs/LegsAnimator.play("idle")
	spawners_pause()
	spawners_cleanup()
	$Chosen/Hula.break_all()
	disable_input()
	$GameMasterAnimator.play_win()

func play_lose():
	print("Game loss")
	do_checks = false
	$Chosen/Graphics/Legs/LegsAnimator.play("idle")
	spawners_pause()
	spawners_cleanup()
	disable_input()
	$GameMasterAnimator.play_lose()

func disable_input():
	$Chosen/StateMachine._active = false
	$Chosen/PauseMenu.set_process_unhandled_input(false)

func spawners_cleanup():
	$HaloopSpawner.fade_all()
	$SmiteSpawner.explode_all()

func spawners_pause():
	$HaloopSpawner.active = false
	$SmiteSpawner.active = false
