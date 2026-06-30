class_name AreaSlider
extends Area3D

@onready var path: Path3D = $"../Path"

func _ready() -> void:
	pass

func move_to(pos:Vector3) -> void:
	self.position = path.curve.get_closest_point(pos)

func get_value() -> void:
	path.curve.get_closest_offset(self.position)
