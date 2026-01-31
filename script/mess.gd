extends Node2D

@onready var text: RichTextLabel = $text
@export var info : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text.text = "[center]"
	text.text += info

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		text.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		text.visible = false
