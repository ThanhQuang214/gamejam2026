extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.windup.connect(_windup)
	Global.winddown.connect(_winddown)


func _windup():
	set_collision_mask_value(1,true)

func _winddown():
	set_collision_mask_value(1,false)

func _on_body_entered(body: Node2D) -> void:
	Global.emit_signal("boost_jump")
