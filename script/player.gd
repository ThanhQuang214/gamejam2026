extends CharacterBody2D

const SPEED = 150
const JUMP_VELOCITY = -250
var mask: int = 0
var giant: bool = false
var mask3: bool = false

var Jump_High = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var aura:AnimatedSprite2D = $Aura
func _ready() -> void:
	Global.mask4_active.connect(_mask4_power)
	Global.mask3_active.connect(_mask3_power)
	Global.mask2_active.connect(_mask2_power)
	Global.mask1_active.connect(_mask1_power)
	Global.mask_reset.connect(_mask_power_reset)
	
	Global.giant.connect(up_giant)
	
	Global.boost_jump.connect(_boost_jump)
	Global.dead.connect(revive)
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
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D and giant:
			c.get_collider().apply_central_impulse(-c.get_normal() * 40)

func revive():
	global_position = Global.returnCoordinate

func _mask_power_reset() -> void:
	aura.play("mask0")
	if (mask == 2):
		set_collision_mask_value(3, false)
	
	if (mask == 1):
		Global.emit_signal("winddown")
	
	if (mask == 3):
		mask3 = false
		
	if (mask == 4):
		set_collision_mask_value(5,true)

func _mask4_power() -> void:
	_mask_power_reset()
	if (mask == 4):
		mask = 0
		return
	
	mask = 4
	set_collision_mask_value(5,false)
	aura.play("mask4")

func _mask3_power() -> void:
	_mask_power_reset()
	if (mask == 3):
		mask = 0
		return
	
	mask = 3
	mask3 = true
	aura.play("mask3")
	
func _mask2_power() -> void:
	_mask_power_reset()
	if mask == 2:
		mask = 0
		return
		
	set_collision_mask_value(3, true)
	mask = 2
	aura.play("mask2")
	
func _mask1_power() -> void:
	_mask_power_reset()
	if mask == 1:
		mask = 0
		return
		
	Global.emit_signal("windup")
	mask = 1
	aura.play("mask1")
func _boost_jump():
	Jump_High = 2

func up_giant():
	if not giant and mask3:
		scale = Vector2(2,2)
		giant = true
	elif giant:
		scale = Vector2(1,1)
		_mask_power_reset()
		giant = false

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
