extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var ray_cast: RayCast3D = $Camera3D/RayCast3D

var selected_button : AreaButton
var selected_slider : AreaSlider
var grabed_slider : bool = false

const thing:Array[int] = [0,4,8]

func _ready() -> void:
	#$Window.popup()
	pass

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var screen_pos: Vector2 = $Node2D.get_local_mouse_position()
	var project: Vector3 = camera.project_position(screen_pos, 0.5)
	var direction: Vector3 = camera.global_position.direction_to(project)
	if grabed_slider:
		var global_pos : Vector3 = camera.global_position + direction * camera.global_position.distance_to(selected_slider.get_parent().global_position)
		selected_slider.move_to( selected_slider.path.to_local(global_pos) )
		#$sadf.global_position = camera.global_position + direction * camera.global_position.distance_to(selected_slider.get_parent().global_position)
	
	ray_cast.look_at(project)
	if ray_cast.is_colliding():
		if ray_cast.get_collider() is AreaButton and !grabed_slider: 
			if ray_cast.get_collider() == selected_button:
				pass
			else :
				if selected_button:
					selected_button.toggle(false)
				selected_button = ray_cast.get_collider()
				selected_button.toggle(true)
		else :
			if selected_button:
				selected_button.toggle(false)
				selected_button = null
		if ray_cast.get_collider() is AreaSlider:
			if ray_cast.get_collider() == selected_slider:
				pass
			else :
				selected_slider = ray_cast.get_collider()
	else :
		if selected_button:
			selected_button.toggle(false)
			selected_button = null
		if selected_slider and !grabed_slider:
			selected_slider = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if selected_button:
				selected_button.click()
			elif selected_slider:
				grabed_slider = true
		elif event.button_index == 1 and !event.pressed:
			if selected_slider:
				grabed_slider = false
				
	if event.is_action_pressed("cheat_1"):
		var list :Array[int] = $Node3D.get_idxs_of_toggled_buttons()
		print(list)
		if list == thing:
			print("This Will Work")
	elif event.is_action_pressed("cheat_2"):
		$Node3D.untoggle_all_buttons()
