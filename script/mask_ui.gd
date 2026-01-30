extends Control

var isOpen: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func open():
	visible = true
	isOpen = true
func close():
	visible = false
	isOpen = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mask"):
		if isOpen == false:
			open()
		else:
			close()

#ui mask
func _on_texture_button_pressed() -> void:
	if isOpen:
		close()
	else:
		open()

func _on_mask_2_but_pressed() -> void:
	Global.emit_signal("mask2_active")
	close()


func _on_mask_1_but_pressed() -> void:
	Global.emit_signal("mask1_active")
	close()
