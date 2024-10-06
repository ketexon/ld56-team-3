class_name Shop
extends Control

static var instance: Shop

@export var button_prefab: PackedScene
@onready var button_container: Control = %ShopButtonContainer

func _ready():
	instance = self
	visible = false
	for shop_item in Colony.player_colony.available_shop_items:
		var button := button_prefab.instantiate() as Button
		button_container.add_child(button)
		button.initialize(shop_item)
