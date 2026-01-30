extends Node2D


func _ready():
	pass

func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
