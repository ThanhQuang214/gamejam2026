extends Control

var current_mask := 0
var isOpen: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isOpen = false
	visible = false

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

	if event.is_action_pressed("ui_change"):
		current_mask += 1
		if current_mask > 4:
			current_mask = 0

		match current_mask:
			0:
				# không mask
				Global.emit_signal("mask_reset")
				Global.emit_signal("mask_change")
			1:
				_on_mask_1_but_pressed()
			2:
				_on_mask_2_but_pressed()
			3:
				_on_mask_3_but_pressed()
			4:
				_on_mask_4_but_pressed()


#ui mask
func _on_texture_button_pressed() -> void:
	if isOpen:
		close()
	else:
		open()

func _on_mask_1_but_pressed() -> void:
	Global.emit_signal("mask1_active")
	current_mask = 1
	close()
	Global.emit_signal("mask_change")

func _on_mask_2_but_pressed() -> void:
	Global.emit_signal("mask2_active")
	current_mask =2 
	close()
	Global.emit_signal("mask_change")

func _on_mask_3_but_pressed() -> void:
	Global.emit_signal("mask3_active")
	current_mask =3
	close()
	Global.emit_signal("mask_change")


func _on_mask_4_but_pressed() -> void:
	Global.emit_signal("mask4_active")
	current_mask = 4
	close()
	Global.emit_signal("mask_change")
