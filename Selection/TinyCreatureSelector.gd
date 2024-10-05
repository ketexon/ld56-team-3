class_name TinyCreatureSelector
extends Control

var mouse_pos_start: Vector2
var selecting := false

@onready var rect: NinePatchRect = %Rect

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.shift_pressed:
			if event.is_pressed():
				mouse_pos_start = get_global_mouse_position()
				position = mouse_pos_start
				rect.size = Vector2.ZERO
				selecting = true
			else:
				selecting = false

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var cur_mouse_pos := get_global_mouse_position()
		var delta_mouse_pos := cur_mouse_pos - mouse_pos_start

		position = mouse_pos_start
		if delta_mouse_pos.x < 0:
			position.x = mouse_pos_start.x + delta_mouse_pos.x
		if delta_mouse_pos.y < 0:
			position.y = mouse_pos_start.y + delta_mouse_pos.y

		rect.size = delta_mouse_pos.abs()
