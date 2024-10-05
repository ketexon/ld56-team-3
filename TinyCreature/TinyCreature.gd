class_name TinyCreature
extends CharacterBody2D

enum Role {
	UNASSIGNED,
	MONARCH,
	WARRIOR,
	LUMBERJACK,
	FORAGER,
	MINER,
	AMBASSADOR,
	ROYAL,
}

static var role_name_dict = {
	Role.UNASSIGNED: "Unassigned",
	Role.MONARCH: "Monarch",
	Role.WARRIOR: "Warrior",
	Role.LUMBERJACK: "Lumberjack",
	Role.FORAGER: "Forager",
	Role.MINER: "Miner",
	Role.AMBASSADOR: "Ambassador",
	Role.ROYAL: "Royal",
}

@export var role: Role

func set_selected(_value: bool):
	pass # TODO: UI for if selected
