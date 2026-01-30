extends Area2D

@export var item_resource: ItemData:
	set(value):
		item_resource = value
		if is_inside_tree() and item_resource:
			$Sprite2D.texture = item_resource.drop_sprite

func _ready():
	if item_resource:
		$Sprite2D.texture = item_resource.drop_sprite

func collect():
	print("Đã nhặt: ", item_resource.name)
	queue_free()
