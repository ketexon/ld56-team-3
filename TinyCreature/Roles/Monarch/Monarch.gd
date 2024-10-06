class_name Monarch
extends TinyCreatureRole

@onready var destination: Vector2 = global_position

var moving := false

func _unhandled_input(event: InputEvent) -> void:
	if not enabled: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			destination = get_global_mouse_position()
			var disp = destination - tiny_creature.global_position
			if not disp.is_zero_approx():
				moving = true
				base_movement_ai.enabled = false

				tiny_creature.running = false
				tiny_creature.movement_dir = disp


func _process(delta: float) -> void:
	if not enabled: return
	if moving:
		var disp = destination - tiny_creature.global_position
		# if destination is the opposite dir as movement dir, stop moving
		if disp.dot(tiny_creature.movement_dir) < 0:
			moving = false
			base_movement_ai.enabled = true

func on_enabled_changed() -> void:
	moving = false