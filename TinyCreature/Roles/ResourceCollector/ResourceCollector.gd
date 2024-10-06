class_name ResourceCollector
extends TinyCreatureRole

const BASE_HIT_DELAY: float = 1.0

@export var resource_type: GResource.Type
@onready var destination: Vector2 = global_position

var resource_stat: int:
	get:
		match resource_type:
			GResource.Type.WOOD:
				return tiny_creature.lumberjack_skill
			GResource.Type.MUSHROOMS:
				return tiny_creature.foraging_skill
			GResource.Type.JEWELS:
				return tiny_creature.mining_skill
		assert(false)
		return 0

var hit_delay: float:
	get:
		return 2 * BASE_HIT_DELAY / (resource_stat + 2)

var target_resource: GResource = null
var target_resource_closest_point: Vector2

var hit_t := 0.0

var visible_resources: Array[GResource]:
	get:
		var a: Array[GResource] = []
		a.assign(colony.visible_resources[resource_type])
		return a

var touching_resource: bool = false

func _ready():
	super._ready()

	tiny_creature.colony.resource_visibility_changed.connect(_resource_visibility_changed)

func _process(delta: float) -> void:
	super._process(delta)
	if not enabled: return

	if target_resource:
		_collect_resource(delta)

func _resource_visibility_changed(res: GResource, res_visibile: bool):
	if not enabled: return
	# resource became invisible
	if res == target_resource and not res_visibile:
		_stop_collecting_resource()
		_try_collect_new_resource()
	# new resource
	elif target_resource == null and res.type == resource_type and res_visibile:
		target_resource = res
		target_resource_closest_point = get_resource_closest_point(target_resource)
		_start_collecting_resource()

func get_resource_closest_point(res: GResource) -> Vector2:
	return Util.closest_point_rect(res.shape, tiny_creature.global_position)

func _choose_closest_resource() -> GResource:
	var closest: GResource = null
	var closest_dist: float = INF
	for res in visible_resources:
		if not closest:
			closest = res
			closest_dist = (
				get_resource_closest_point(res)
					.distance_squared_to(tiny_creature.global_position)
			)
		else:
			var cur_dist := closest.global_position.distance_squared_to(
				tiny_creature.global_position
			)
			if closest_dist > cur_dist:
				closest = res

	return closest

func _start_collecting_resource():
	touching_resource = false
	base_movement_ai.enabled = false
	hit_t = 0
	var closest_point = get_resource_closest_point(target_resource)
	tiny_creature.movement_dir = closest_point - global_position
	tiny_creature.collided.connect(_on_collided)

func _on_collided(collision: KinematicCollision2D):
	var collider := collision.get_collider() as Node2D
	print("COLLIDING")
	if collider == target_resource:
		touching_resource = true
		tiny_creature.collided.disconnect(_on_collided)

func _collect_resource(delta):
	if not target_resource or not touching_resource:
		return

	hit_t += delta
	if hit_t >= hit_delay:
		hit_t -= hit_delay
		if target_resource.hit():
			tiny_creature.colony.add_resource(target_resource.type)



func _stop_collecting_resource():
	base_movement_ai.enabled = true
	tiny_creature.collided.disconnect(_on_collided)

func _try_collect_new_resource():
	# see if there are any other visible resources
	target_resource = _choose_closest_resource()
	if target_resource:
		_start_collecting_resource()

func on_enabled_changed() -> void:
	if enabled:
		_try_collect_new_resource()
	else:
		_stop_collecting_resource()
