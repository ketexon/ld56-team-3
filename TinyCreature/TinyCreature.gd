class_name TinyCreature
extends CharacterBody2D

enum Role {
	UNASSIGNED,
	MONARCH,
	RESOURCE_COLLECTOR,
	WARRIOR,
	AMBASSADOR,
}

@export var role: Role

func set_selected(_value: bool):
	pass # TODO: UI for if selected