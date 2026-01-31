extends Node2D
@export var Player: CharacterBody2D

var canJump: bool = false;

func _ready():
	Global.giant.connect(_scaleUpSound)

func _scaleUpSound():
	if Player.mask == 3:
		$ScaleUp.play()

func _process(float):
	if (Player != null):
		
		#Jumping Sound
		canJump = canJump || Player.is_on_floor()
		if Input.is_action_just_pressed("ui_jump") == true && canJump:
			$Jumping.play()
			canJump = false
		canJump = canJump && Player.is_on_floor()
