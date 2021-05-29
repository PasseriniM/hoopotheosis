extends Node2D

var gm = preload("res://scenes/GameMaster.tscn")
var current_game

func _show_intro():
	play_intro(1)

func restart():
	current_game.visible = false
	current_game.queue_free()
	play_intro(5)

func play_intro(speed):
	print("Game Started")
	$Intro.visible = true
	$Intro/Animator.playback_speed = speed
	$Intro/Sparkles.speed_scale = speed
	$Intro/Animator.play("mount_hulympus")

func game_start():
	current_game = gm.instance()
	current_game.connect("game_win", self, "show_outro")
	current_game.connect("game_loss", self, "restart")
	self.add_child(current_game)
	$Intro.visible = false

func show_outro():
	$Outro.visible = true
	current_game.visible = false
	current_game.queue_free()
	$Outro/CreditsAnimator.play("roll_credits")
	$Outro/OutroMusic.play()
