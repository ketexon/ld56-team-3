class_name Colony
extends Node2D

@export var player: bool = false

static var player_colony: Colony

func _ready() -> void:
	if player:
		player_colony = self
