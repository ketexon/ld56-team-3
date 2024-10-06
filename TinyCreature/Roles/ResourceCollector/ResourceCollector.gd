class_name ResourceCollector
extends TinyCreatureRole

const HIT_DELAY: float = 1.0

@export var resource_type: GResource.Type

@onready var destination: Vector2 = global_position

var target_resource: GResource = null

var visible_resources:
	get:
		return colony.visible_resource[resource_type]

var touching_resource: bool = false

func _process(delta: float) -> void:
	if not enabled: return
	if target_resource:
		if target_resource in visible_resources:
			_collect_resource()
		else:
			_stop_collecting_resource()
	else:
		if not visible_resources.is_empty():
			for res in visible_resources:
				if not target_resource:
					target_resource = res
				else:
					var target_dist = target_resource.global_position.distance_squared_to(
						tiny_creature.global_position
					)
					var cur_dist = target_resource.global_position.distance_squared_to(
						tiny_creature.global_position
					)
					if cur_dist < target_dist:
						target_resource = res
			_start_collecting_resource()


func _start_collecting_resource():
	phase = CollectResourcePhase.MOVING
	base_movement_ai.enabled = false
	tiny_creature.movement_dir = target_resource.global_position - global_position

func _collect_resource():
	pass


func _stop_collecting_resource():
	base_movement_ai.enabled = true

func on_enabled_changed() -> void:
	base_movement_ai.enabled = true