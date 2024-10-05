class_name CameraControls
extends Camera2D

@export var colony_view_zoom = 20.0
@export var map_view_zoom = 1.0
@export var zoom_duration = 1.0
@export var pan_speed: float = 10.0
@export var scroll_speed: float = 10.0
@export var scroll_sensitivity: float = 0.01

var start_cursor_pos: Vector2
var start_pos: Vector2

var zoom_goal: float = colony_view_zoom

var last_zoom_level: int = -1

var zoom_percent: float = 0
var panning := false

@onready var pan_goal: Vector2 = position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and not event.shift_pressed:
				start_cursor_pos = get_viewport().get_mouse_position()
				start_pos = position
				panning = true
			elif not event.pressed:
				panning = false
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			set_zoom_percent(zoom_percent + scroll_sensitivity)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			set_zoom_percent(zoom_percent - scroll_sensitivity)

	if event.is_action_pressed("center_on_colony"):
		center_on_player()

	var cur_zoom_level = null
	if event.is_action_pressed("zoom_0"):
		set_zoom_percent(0)
		cur_zoom_level = 0
	if event.is_action_pressed("zoom_1"):
		set_zoom_percent(0.33)
		cur_zoom_level = 1
	if event.is_action_pressed("zoom_2"):
		set_zoom_percent(0.66)
		cur_zoom_level = 2
	if event.is_action_pressed("zoom_3"):
		set_zoom_percent(1)
		cur_zoom_level = 3

	if cur_zoom_level != null:
		if cur_zoom_level == last_zoom_level:
			center_on_player()
		last_zoom_level = cur_zoom_level


func _process(delta: float) -> void:
	if panning:
		var cur_pos := get_viewport().get_mouse_position()
		var delta_pos := cur_pos - start_cursor_pos
		pan_goal = start_pos - delta_pos/zoom.x

	zoom.x = lerpf(
		zoom.x,
		zoom_goal,
		delta * scroll_speed
	);
	zoom.y = zoom.x

	position = lerp(position, pan_goal, delta * pan_speed)


func set_zoom_percent(percent: float):
	zoom_percent = clampf(percent, 0, 1)
	zoom_goal = lerp(colony_view_zoom, map_view_zoom, sqrt(zoom_percent))

func center_on_player():
	pan_goal = Colony.player_colony.position
