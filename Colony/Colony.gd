class_name Colony
extends Node2D

@export var player: bool = false
@export var power: int = 0
@export var persuasion: int = 0
@export var reputation: int = 0

@export var monarch: TinyCreature
@export var tiny_creatures: Array[TinyCreature]

@export var  available_shop_items: Array[ShopItem]

@export var wood: int
@export var mushrooms: int
@export var jewels: int


var radius: float:
	get:
		var n = len(tiny_creatures)
		return 256 * pow(1.5, n/32.0)

static var player_colony: Colony

func _ready() -> void:
	if player:
		player_colony = self

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

	
