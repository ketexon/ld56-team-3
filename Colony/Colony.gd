class_name Colony
extends Node2D

@export var player: bool = false
@export var power: int = 0
@export var persuasion: int = 0
@export var reputation: int = 0

@export var monarch: TinyCreature
@export var tiny_creatures: Array[TinyCreature]

var radius: float:
	get:
		var n = len(tiny_creatures)
		return 256 * pow(1.5, n/32.0)

static var player_colony: Colony

func _ready() -> void:
	if player:
		player_colony = self
