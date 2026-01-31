extends CharacterBody2D

func setup(dir: Vector2, speed: float):
	velocity = dir * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if (collision != null):
		if collision.get_collider() is CharacterBody2D:
			Global.emit_signal("dead")
		
		queue_free()
