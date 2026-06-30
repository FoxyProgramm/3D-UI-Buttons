class_name AreaButton
extends Area3D

signal button_clicked
signal button_toggled(state:bool)

enum TYPE {PRESS, TOGGLE, HOLD}
@export_enum("Press", "Toggle", "Hold") var button_type : int = 1
@onready var mesh: MeshInstance3D = $Mesh

var in_click: bool = false
var toggled: bool = false
var hovered: bool = false

var tween : Tween
func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()

func _ready() -> void:
	pass

func toggle(state:bool) -> void:
	hovered = state
	if in_click: return
	if toggled: return
	reset_tween()
	tween.tween_property(mesh, "position", Vector3(0,0,-0.15) if state else Vector3.ZERO, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func update_toggle() -> void:
	toggle(hovered)

func click() -> void:
	match button_type:
		TYPE.PRESS:
			if in_click: return
			in_click = true
			reset_tween()
			tween.tween_property(mesh, "position", Vector3(0,0,0.25), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			#tween.tween_property(mesh, "position", Vector3(0,0,-0.15) if hovered else Vector3.ZERO, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "in_click", false, 0)
			tween.tween_callback(self.update_toggle)
			button_clicked.emit()
		TYPE.TOGGLE:
			toggled = !toggled
			var result_value: float
			if toggled:
				result_value = 0.25
			else :
				if hovered:
					result_value = -0.15
				else :
					result_value = 0.0
			button_toggled.emit(toggled)
			reset_tween()
			tween.tween_property(mesh, "position", Vector3(0,0,result_value), 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
