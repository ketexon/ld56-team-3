class_name TinyCreatureRole
extends Node2D

var enabled: bool:
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

func _ready():
	enabled = false

func _process(_delta):
	if enabled and role != tiny_creature.role:
		enabled = false
	if not enabled and role == tiny_creature.role:
		enabled = true

func on_enabled_changed() -> void:
	pass
