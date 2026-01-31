extends Area2D

var status: int = 0;
var countdown: float = 0;

func _on_ready():
	status = 0
	countdown = 0

func _process(delta: float) -> void:
	if (status == 0):
		$AnimatedSprite2D.play("default")
		
	if (status == 2 && global_position != Global.returnCoordinate):
		status = 0;
		$AnimatedSprite2D.play("default")
		
	if (status != 1):
		return
	
	countdown -= delta
	if (countdown <= 0):
		countdown = 0
		status = 2
		$AnimatedSprite2D.play("active")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D && status == 0:
		status = 1
		$AnimatedSprite2D.play("rising")
		countdown = 1
		Global.returnCoordinate = global_position
