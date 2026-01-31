extends Node2D

@export var arrow_scene: PackedScene
@export var shoot_point: Node2D
@export var shoot_speed := 300.0
@export var shoot_direction = Vector2(1, 0)

var cooldown: float = 5
var burstcooldown: float = 0
var burstcnt = 0

func shoot(direction: Vector2):
	if arrow_scene == null:
		return

	var arrow = arrow_scene.instantiate()
	arrow.global_position = shoot_point.global_position
	arrow.setup(direction.normalized(), shoot_speed)

	get_tree().current_scene.add_child(arrow)

func _process(delta: float) -> void:
	cooldown -= delta
	burstcooldown -= delta
	
	if (cooldown <= 0):
		cooldown = 5
		burstcnt = 3
		burstcooldown = 0
	
	if (burstcnt > 0 && burstcooldown <= 0):
		burstcnt -= 1
		burstcooldown = 0.7
		shoot(shoot_direction)
