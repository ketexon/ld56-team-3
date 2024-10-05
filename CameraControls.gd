class_name CameraControls
extends Camera2D

@export var colony_view_zoom = 20.0
@export var map_view_zoom = 1.0
@export var zoom_duration = 1.0
@export var zoom_curve: Curve

var start_cursor_pos: Vector2
var start_pos: Vector2

var zooming = false
var zoom_start: float = colony_view_zoom
var zoom_goal: float = colony_view_zoom
var zoom_t: float = 0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_cursor_pos = get_viewport().get_mouse_position()
				start_pos = position
	if event.is_action_pressed("center_on_colony"):
		center_on_player()
	if event.is_action_pressed("zoom_0"):
		set_zoom_percent(0)
	if event.is_action_pressed("zoom_1"):
		set_zoom_percent(0.33)
	if event.is_action_pressed("zoom_2"):
		set_zoom_percent(0.66)
	if event.is_action_pressed("zoom_3"):
		set_zoom_percent(1)


func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var cur_pos := get_viewport().get_mouse_position()
		var delta_pos := cur_pos - start_cursor_pos
		position = start_pos - delta_pos

	if zooming:
		zoom_t += _delta
		if zoom_t < zoom_duration:
			var t = zoom_curve.sample(zoom_t / zoom_duration)
			zoom.x = lerpf(
				zoom_start,
				zoom_goal,
				t
			);
			zoom.y = zoom.x

			position = Colony.player_colony.position
		else:
			zoom.x = zoom_goal
			zoom.y = zoom.x
			zooming = false



func set_zoom_percent(percent: float):
	zooming = true
	zoom_t = 0
	zoom_start = zoom.x
	zoom_goal = lerp(colony_view_zoom, map_view_zoom, percent)

func center_on_player():
	pass