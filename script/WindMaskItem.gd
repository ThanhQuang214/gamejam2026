extends Area2D

func _ready():
	pass

func _process(delta: float) -> void:
	if (has_overlapping_bodies()):
		print("hehe")
