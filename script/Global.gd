extends Node

signal mask_change
signal mask4_active
signal mask3_active
signal mask2_active
signal mask1_active
signal mask_reset

signal giant

signal boost_jump

signal windup
signal winddown

signal dead

var returnCoordinate = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
