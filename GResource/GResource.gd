class_name GResource
extends Node

enum Type {
	Wood,
	Mushroom,
	Jewels,
}

@export var type: Type
@export var total_resource: int = 10
@export var hits_per_resource: int = 10

@onready var resource_remaining := total_resource
@onready var hits_remaining := hits_per_resource

func hit() -> bool:
	if resource_remaining == 0:
		return false

	hits_remaining -= 1
	if hits_remaining == 0:
		resource_remaining -= 1

		if resource_remaining == 0:
			queue_free()

		return true

	return false