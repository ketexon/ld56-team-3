class_name Colony
extends Node2D

@export var player: bool = false
@export var power: int = 0
@export var persuasion: int = 0
@export var reputation: int = 0

@export var monarch: TinyCreature
@export var tiny_creatures: Array[TinyCreature]

@onready var visibility_area: Area2D = %VisibilityArea
@onready var colony_ui : Control = %ColonyUI

@export var  available_shop_items: Array[ShopItem]

@export var wood: int
@export var mushrooms: int
@export var jewels: int

var visible_resources: Array[GResource] = []

var radius: float:
	get:
		var n = len(tiny_creatures)
		# return 32 * pow(1.5, n)
		return 64 * sqrt(n)

static var player_colony: Colony

func _ready() -> void:
	if player:
		player_colony = self

	visibility_area.body_entered.connect(_body_entered_visibility)
	visibility_area.body_exited.connect(_body_exited_visibility)


func _physics_process(delta: float) -> void:
	visibility_area.global_position = monarch.global_position


func _body_entered_visibility(body: Node2D):
	if body.is_in_group(&"resources"):
		visible_resources.push_back(body)


func _body_exited_visibility(body: Node2D):
	if body.is_in_group(&"resources"):
		visible_resources.erase(body)


func buy_shop_item(shop_item:ShopItem) -> bool:
	if wood < shop_item.cost_wood:
		return false
	if mushrooms < shop_item.cost_mushroom:
		return false
	if jewels < shop_item.cost_jewel:
		return false
	if power < shop_item.min_power:
		return false
	if persuasion < shop_item.min_persuasion:
		return false
	if reputation < shop_item.min_reputation:
		return false
	return true


func _on_action_1_pressed() -> void:
	print("Action 1")

func _process(delta: float) -> void:
	if CameraControls.viewing_colony:
		colony_ui.visible = true
	elif !CameraControls.viewing_colony:
		colony_ui.visible = false
