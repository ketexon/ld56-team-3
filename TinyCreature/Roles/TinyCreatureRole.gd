class_name TinyCreatureRole
extends Node2D

var enabled:
	get:
		return tiny_creature.role == role
	set(v):
		if enabled != v:
			enabled = v
			on_enabled_changed()

@export var tiny_creature: TinyCreature
@export var role: TinyCreature.Role

@onready var base_movement_ai: TinyCreatureBaseMovementAI = %BaseMovementAI

var colony: Colony:
	get: return tiny_creature.colony

var in_range: bool:
	get:
		return (
			(global_position - colony.monarch.global_position).length_squared()
			< colony.radius * colony.radius
		)

func on_enabled_changed() -> void:
	pass