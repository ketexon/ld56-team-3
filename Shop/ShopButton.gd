class_name ShopButton
extends Button

@export var shop_item: ShopItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_ShopButton_pressed() -> void:
	if Colony.player_colony.buy_shop_item(shop_item): queue_free()

func initialize(shop_item: ShopItem) -> void:
	pass
