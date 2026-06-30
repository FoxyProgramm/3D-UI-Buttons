class_name RotatingThing
extends Area3D

func _ready() -> void:
	set_physics_process(false)

var is_rotating: bool = false
var first_pos: Vector3

func toggle(state:bool, first_pos_:Vector3 = Vector3.ZERO) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
