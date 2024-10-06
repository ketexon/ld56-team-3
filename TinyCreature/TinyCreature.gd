class_name TinyCreature
extends CharacterBody2D

@export var colony: Colony

@export var lumberjack_skill: int = 2
@export var foraging_skill: int = 2
@export var mining_skill: int = 2
@export var max_health: int = 100
@export var damage: int = 5
@export var speed: int = 16

@onready var health := max_health

signal collided(collision: KinematicCollision2D)

const WALKING_SPEED_MULT := 0.5

var movement_dir: Vector2:
	set(value):
		movement_dir = value.normalized() if not value.is_zero_approx() else Vector2.ZERO

var running: bool = false

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

@export var role: Role:
	set(value):
		if role != Role.MONARCH:
			role = value

func set_selected(_value: bool):
	pass # TODO: UI for if selected

func _physics_process(delta: float) -> void:
	velocity = movement_dir * speed * (WALKING_SPEED_MULT if not running else 1)
	move_and_slide()
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		collided.emit(collision)
