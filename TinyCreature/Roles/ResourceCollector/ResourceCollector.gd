class_name ResourceCollector
extends TinyCreatureRole

const HIT_DELAY: float = 1.0

@onready var destination: Vector2 = global_position

var target_resource: GResource = null

func _process(delta: float) -> void:
	if not enabled: return
	if target_resource:
		colony.visible_resources


func on_enabled_changed() -> void:
	target_resource = null