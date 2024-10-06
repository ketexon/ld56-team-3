class_name ResourceCollector
extends TinyCreatureRole

const HIT_DELAY: float = 1.0

@export var resource_type: GResource.Type

@onready var destination: Vector2 = global_position

var target_resource: GResource = null

var visible_resources:
	get:
		return colony.visible_resource[resource_type]

func _process(delta: float) -> void:
	if not enabled: return
	if target_resource:
		if target_resource in visible_resources:
			_collect_resource()
		else:
			_stop_collecting_resource()
	else:
		pass

func _start_collecting_resource():
	pass

func _collect_resource():
	pass

func _stop_collecting_resource():
	base_movement_ai.enabled = true

func on_enabled_changed() -> void:
	base_movement_ai.enabled = true