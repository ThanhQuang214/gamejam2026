extends Area2D

var status: int = 0;
var countdown: float = 0;

func _on_ready():
	status = 0
	countdown = 5

func _process(delta: float) -> void:
	countdown -= delta
	if (countdown <= 0):
		if (status == 0):
			status = 1
			countdown = 3
			$AnimationPlayer.play("pulse_collider")
		else:
			status = 0
			countdown = 2
			$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D && status == 1:
		Global.emit_signal("dead")
