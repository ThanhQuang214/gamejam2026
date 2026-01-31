extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -250
var mask2: bool = false
var mask1: bool = false
var mask: int = 0
var Jump_High = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	Global.mask2_active.connect(_mask2_power)
	Global.mask1_active.connect(_mask1_power)
	
	Global.boost_jump.connect(_boost_jump)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * Jump_High
		Jump_High = 1

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation(direction)
	move_and_slide()

func _mask2_power() -> void:
	if mask2:
		mask2_off()
	else:
		set_collision_mask_value(3,true)
		mask2 = true
		print("water trigger")
		mask1_off()
func mask2_off():
	set_collision_mask_value(3,false)
	mask2 = false
	print("water fail")

func _mask1_power() -> void:
	if mask1:
		mask1_off()
	else:
		Global.emit_signal("windup")
		mask1 = true
		print("wind trigger")
		mask2_off()
func mask1_off():
	Global.emit_signal("winddown")
	mask1 = false
	print("wind false")

func _boost_jump():
	Jump_High = 2
	print("buff jump")
func update_animation(direction: float) -> void:
	# Lật nhân vật theo hướng chạy
	if direction != 0:
		sprite.flip_h = direction < 0

	# Ưu tiên animation trên không
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump") # bay lên
		else:
			sprite.play("fall") # rơi xuống
		return

	# Animation dưới đất
	if abs(velocity.x) > 10:
		sprite.play("run")
	else:
		sprite.play("idle")
