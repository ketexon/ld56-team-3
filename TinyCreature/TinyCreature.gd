class_name TinyCreature
extends CharacterBody2D

@export var colony: Colony

@export var lumberjack_skill: int = 2
@export var foraging_skill: int = 2
@export var mining_skill: int = 2
@export var max_health: int = 100
@export var damage: int = 5
@export var speed: int = 5

@onready var health := max_health

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