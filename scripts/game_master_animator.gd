extends AnimationPlayer

onready var chosen = get_node("../Chosen")
onready var game_camera = get_node("../Chosen/ChosenCamera")
onready var whitescreen = get_node("../Whitescreen")

const fscale = 0.4

func _ready():
	self.set_process_unhandled_input(false)

func play_win():
	var dummy = $WinAnimation/Dummy
	var camera = $WinAnimation/Camera
	var tween = $WinAnimation/Tween
	var messenger = $WinAnimation/Dummy/GodMessenger
	
	get_node("../MusicLoop").stop()
	dummy.global_position = chosen.global_position
	dummy.godness = 1
	camera.global_position = game_camera.global_position
	messenger.global_position = chosen.global_position - Vector2(0, 300)
	whitescreen.global_position.x = chosen.global_position.x
	
	tween.interpolate_property(camera, "zoom", Vector2.ONE, Vector2(fscale, fscale), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(camera, "position", camera.position, camera.position + Vector2(0, -86), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	chosen.visible = false
	camera.current = true
	$WinAnimation.visible = true
	
	self.play("win")

func play_lose():
	var dummy = $LoseAnimation/Dummy
	var camera = $LoseAnimation/Camera
	var tween = $LoseAnimation/Tween
	
	get_node("../MusicLoop").stop()
	dummy.global_position = chosen.global_position
	camera.global_position = game_camera.global_position
	dummy.godness = chosen.godness
	whitescreen.global_position.x = chosen.global_position.x
	
	tween.interpolate_property(dummy, "godness", dummy.godness, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(camera, "zoom", Vector2.ONE, Vector2(fscale, fscale), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(camera, "position", camera.position, camera.position + Vector2(0, 105), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	
	chosen.visible = false
	camera.current = true
	$LoseAnimation.visible = true

	self.play("lose")

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		self.set_process_unhandled_input(false)
		play("fade")
