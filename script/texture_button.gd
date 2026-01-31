extends TextureButton

@export var mask_icons: Array[Texture2D]
@onready var maskui : Control = $"../maskUi"
# index:
# 0 = no mask
# 1 = mask1
# 2 = mask2
# 3 = mask3
# 4 = mask4
func _ready() -> void:
	texture_normal = mask_icons[0]
	texture_hover = mask_icons[5]
	Global.mask_change.connect(update_mask_ui)

func update_mask_ui():
	if maskui.current_mask < mask_icons.size():
		texture_normal = mask_icons[maskui.current_mask]
		texture_hover = mask_icons[maskui.current_mask + 5]
