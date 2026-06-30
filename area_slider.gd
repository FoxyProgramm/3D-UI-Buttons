class_name AreaSlider
extends Area3D

@onready var path: Path3D = $"../Path"

@onready var camera : Camera3D = get_tree().get_viewport()

#func _ready() -> void:
	#var first_value:float = to_global(path.curve.get_point_position(0)).direction_to()
	#print("")

func move_to(pos:Vector3) -> void:
	self.position = path.curve.get_closest_point(pos)

func get_value() -> float:
	return path.curve.get_closest_offset(self.position)
