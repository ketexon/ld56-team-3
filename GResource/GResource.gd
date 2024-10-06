class_name GResource
extends StaticBody2D

enum Type {
	WOOD,
	MUSHROOMS,
	JEWELS,
}

@export var type: Type
@export var total_resource: int = 10
@export var hits_per_resource: int = 100

@onready var resource_remaining := total_resource
@onready var hits_remaining := hits_per_resource

@onready var shape: CollisionShape2D = $CollisionShape2D

func hit() -> bool:
	print("HIT: %d %d" % [hits_remaining, resource_remaining])
	if resource_remaining == 0:
		return false

	hits_remaining -= 1
	if hits_remaining == 0:
		resource_remaining -= 1
		hits_remaining = hits_per_resource

		if resource_remaining == 0:
			queue_free()

		return true

	return false