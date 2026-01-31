extends Area2D

func _on_ready():
	visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.emit_signal("dead")
