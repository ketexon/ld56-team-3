class_name TinyCreatureSelector
extends Control

var mouse_pos_start: Vector2
var selecting := false

@onready var rect: NinePatchRect = %Rect

static var selected_tiny_creatures: Array[TinyCreature] = []

func _ready():
	rect.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and event.shift_pressed:
				selected_tiny_creatures.clear()
				mouse_pos_start = get_global_mouse_position()
				position = mouse_pos_start
				rect.size = Vector2.ZERO
				selecting = true
				rect.visible = true
			elif not event.is_pressed() and selecting:
				selecting = false
				rect.visible = false

				selected_tiny_creatures_set_selected(false)
				selected_tiny_creatures = get_selected_tiny_creatures()
				selected_tiny_creatures_set_selected(true)

static func selected_tiny_creatures_set_selected(v: bool):
	for tiny_creature in selected_tiny_creatures:
		tiny_creature.set_selected(v)

static func selected_tiny_creatures_set_role(role: TinyCreature.Role, keep_selected: bool = false):
	for tiny_creature in selected_tiny_creatures:
		tiny_creature.role = role
	if not keep_selected:
		selected_tiny_creatures.clear()


func get_selected_tiny_creatures() -> Array[TinyCreature]:
	var mouse_pos_end := get_global_mouse_position()

	var rect_shape_rid := PhysicsServer2D.rectangle_shape_create()

	var half_extents = (mouse_pos_end - mouse_pos_start).abs()
	var center = (mouse_pos_start + mouse_pos_end)/2
	PhysicsServer2D.shape_set_data(rect_shape_rid, half_extents)

	var query = PhysicsShapeQueryParameters2D.new()
	query.collide_with_areas = true
	query.shape_rid = rect_shape_rid
	query.transform = Transform2D.IDENTITY.translated(center)

	var space_state := get_world_2d().direct_space_state
	var results := space_state.intersect_shape(query)

	PhysicsServer2D.free_rid(rect_shape_rid)

	var out: Array[TinyCreature] = []
	for result in results:
		var collider := result.collider as Node
		if collider is TinyCreature and collider.is_in_group(&"player_tiny_creatures"):
			out.push_back(collider)

	return out



func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and selecting:
		var cur_mouse_pos := get_global_mouse_position()
		var delta_mouse_pos := cur_mouse_pos - mouse_pos_start

		position = mouse_pos_start
		if delta_mouse_pos.x < 0:
			position.x = mouse_pos_start.x + delta_mouse_pos.x
		if delta_mouse_pos.y < 0:
			position.y = mouse_pos_start.y + delta_mouse_pos.y

		rect.size = delta_mouse_pos.abs()
