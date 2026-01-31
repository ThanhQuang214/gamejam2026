extends CharacterBody2D

var timerEffect: float = 0

func setup(dir: Vector2, speed: float):
	velocity = dir * speed

func _physics_process(delta):
	if (timerEffect <= 0):
		$AudioStreamPlayer2D.play()
		timerEffect = randf_range(0.5, 1)
		
	var collision = move_and_collide(velocity * delta)
	if (collision != null):
		if collision.get_collider() is CharacterBody2D:
			Global.emit_signal("dead")
		
		queue_free()
