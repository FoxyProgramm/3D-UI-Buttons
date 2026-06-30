class_name ButtonPanel
extends Node3D

@export var horizontal_buttons: int = 3
@export var vertical_buttons: int = 3
@export var button_spacing : float = 0.15

var button := preload("res://button.tscn")

var buttons : Array[AreaButton] = []

func get_idxs_of_toggled_buttons() -> Array[int]:
	var result: Array[int] = []
	var idx: int = 0
	for button_ in buttons:
		if button_.toggled:
			result.append(idx)
		idx += 1
	return result

func untoggle_button(idx:int) -> void:
	buttons[idx].toggle(false)

func untoggle_all_buttons() -> void:
	for button_ in buttons:
		if button_.toggled:
			button_.toggled = false
			button_.toggle(button_.hovered)
			await get_tree().create_timer(0.04).timeout

var requested_button_sequense : Array[int] = [8,8,5,5,3,3,0,0,4,4,4,4]
var button_sequense : Array[int] = []

func press_button(idx:int) -> void:
	if button_sequense.size() == requested_button_sequense.size():
		button_sequense.pop_front()
	button_sequense.append(idx)
	if button_sequense == requested_button_sequense:
		print("OMAGAD")
	print(button_sequense)

func _ready() -> void:
	for j in range(vertical_buttons):
		for i in range(horizontal_buttons):
			var new_button = button.instantiate()
			self.add_child(new_button)
			buttons.append(new_button)
			new_button.button_clicked.connect(press_button.bind(vertical_buttons*j+i))
			new_button.position = Vector3((-i * .5) + (-i * button_spacing), (-j * .5) + (-j * button_spacing), 0)
