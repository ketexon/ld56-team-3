class_name Colony
extends Node2D

@export var player: bool = false
@export var power: int = 0
@export var persuasion: int = 0
@export var reputation: int = 0

@export var monarch: TinyCreature
@export var tiny_creatures: Array[TinyCreature]

@onready var visibility_area: Area2D = %VisibilityArea

var visible_resources: Array[GResource] = []

var radius: float:
	get:
		var n = len(tiny_creatures)
		return 256 * pow(1.5, n/32.0)

static var player_colony: Colony

func _ready() -> void:
	if player:
		player_colony = self

	visibility_area.body_entered.connect(_body_entered_visibility)
	visibility_area.body_exited.connect(_body_exited_visibility)


func _physics_process(delta: float) -> void:
	visibility_area.global_position = monarch.global_position


func _body_entered_visibility(body: Node2D):
	print(body)
	if body.is_in_group(&"resources"):
		print("ADDED")
		visible_resources.push_back(body)

func _body_exited_visibility(body: Node2D):
	print(body)
	if body.is_in_group(&"resources"):
		print("REMOVED")
		visible_resources.erase(body)