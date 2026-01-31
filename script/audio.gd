extends Node2D
@export var Player: CharacterBody2D

var isWalking: bool = false;
var canJump: bool = false;

func _ready():
	Global.giant.connect(_scaleUpSound)

func _scaleUpSound():
	if Player.mask == 3:
		$ScaleUp.play()

func _process(float):
	if (Player != null):
		#Walking Sound
		if Player.velocity != Vector2(0, 0) && Player.is_on_floor():
			if !isWalking:
				isWalking = true
				$FootStep.play()
		elif isWalking:
			isWalking = false
			$FootStep.stop()
		
		#Jumping Sound
		canJump = canJump || Player.is_on_floor()
		if Input.is_action_just_pressed("ui_jump") == true && canJump:
			$Jumping.play()
			canJump = false
		canJump = canJump && Player.is_on_floor()
