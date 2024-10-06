class_name TinyCreatureRole
extends Node2D

var enabled:
	get:
		return tiny_creature.role == role

@export var tiny_creature: TinyCreature
@export var role: TinyCreature.Role