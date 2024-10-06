class_name Monarch
extends TinyCreatureRole

@onready var destination: Vector2 = position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			destination = get_global_mouse_position()

func _process(delta: float) -> void:
	if enabled:
		tiny_creature.movement_dir = destination - tiny_creature.global_position
