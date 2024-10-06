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

func on_enabled_changed() -> void:
	pass