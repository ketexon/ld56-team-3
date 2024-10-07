class_name ShopButton
extends Button

var shop_item: ShopItem

@onready var item_name: Label = %ItemName
@onready var item_icon: TextureRect = %ItemIcon

@onready var cost_wood: Label = %CostWood
@onready var cost_mushroom: Label = %CostMushroom
@onready var cost_jewel: Label = %CostJewel

@onready var min_power: Label = %MinPowerReq
@onready var min_persuasion: Label = %MinPersuasionReq
@onready var min_reputation: Label = %MinReputationReq

@onready var power_stat_change: Label = %PowerStatChange
@onready var persuasion_stat_change: Label = %PersuasionStatChange
@onready var reputation_stat_change: Label = %ReputationStatChange
@onready var attack_stat_change: Label = %AttackStatChange
@onready var speed_stat_change: Label = %SpeedStatChange
@onready var health_stat_change: Label = %HealthStatChange

@onready var power_box: HBoxContainer = %Power
@onready var persuasion_box: HBoxContainer = %Persuasion
@onready var reputation_box: HBoxContainer = %Reputation
@onready var attack_box: HBoxContainer = %Attack
@onready var speed_box: HBoxContainer = %Speed
@onready var health_box: HBoxContainer = %Health

@onready var min_power_box: HBoxContainer = %MinPower
@onready var min_persuasion_box: HBoxContainer = %MinPersuasion
@onready var min_reputation_box: HBoxContainer = %MinReputation
@onready var wood_box: HBoxContainer = %Wood
@onready var mushroom_box: HBoxContainer = %Mushrooms
@onready var jewel_box: HBoxContainer = %Jewels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_ShopButton_pressed() -> void:# 
	if Colony.player_colony.buy_shop_item(shop_item): queue_free()
	print("bought item")

func initialize(shop_item: ShopItem) -> void:
	self.shop_item = shop_item
	item_name.set_text(shop_item.name)
	item_icon.set_texture(shop_item.texture)

	# item stat changes

	if shop_item.mult_power == 1:
		if shop_item.delta_power > 0:
			power_stat_change.set_text("+%d" % shop_item.delta_power)
		else:
			power_stat_change.set_text("%d" % shop_item.delta_power)
	else:
		power_stat_change.set_text("x%d" % shop_item.mult_power)

	if shop_item.mult_persuasion == 1:
		if shop_item.delta_persuasion > 0:
			persuasion_stat_change.set_text("+%d" % shop_item.delta_persuasion)
		else:
			persuasion_stat_change.set_text("%d" % shop_item.delta_persuasion)
	else:
		persuasion_stat_change.set_text("x%d" % shop_item.mult_persuasion)

	if shop_item.mult_reputation == 1:
		if shop_item.delta_reputation > 0:
			reputation_stat_change.set_text("+%d" % shop_item.delta_reputation)
		else:
			reputation_stat_change.set_text("%d" % shop_item.delta_reputation)
	else:
		reputation_stat_change.set_text("x%d" % shop_item.mult_reputation)
	
	attack_stat_change.set_text("x%d" % shop_item.mult_attack)
	speed_stat_change.set_text("x%d" % shop_item.mult_speed)
	health_stat_change.set_text("x%d" % shop_item.mult_health)

	
	# item requirements / cost

	cost_wood.set_text("%d" % shop_item.cost_wood)
	cost_mushroom.set_text("%d" % shop_item.cost_mushroom)
	cost_jewel.set_text("%d" % shop_item.cost_jewel)

	min_power.set_text(">%d" % shop_item.min_power)
	min_persuasion.set_text(">%d" % shop_item.min_persuasion)
	min_reputation.set_text(">%d" % shop_item.min_reputation)

	if shop_item.delta_power != 0:
		power_box.visible = true
	elif shop_item.mult_power != 1:
		power_box.visible = true

	if shop_item.delta_persuasion != 0:
		persuasion_box.visible = true
	elif shop_item.mult_persuasion != 1:
		persuasion_box.visible = true

	if shop_item.delta_reputation != 0:
		reputation_box.visible = true
	elif shop_item.mult_reputation != 1:
		reputation_box.visible = true
	
	if shop_item.mult_attack != 1:
		attack_box.visible = true
	
	if shop_item.mult_speed != 1:
		speed_box.visible = true
	
	if shop_item.mult_health != 1:
		health_box.visible = true

	if shop_item.min_power > 0:
		min_power_box.visible = true 
	
	if shop_item.min_persuasion > 0:
		min_persuasion_box.visible = true 
	
	if shop_item.min_reputation > 0:
		min_reputation_box.visible = true 
	
	if shop_item.cost_wood > 0:
		wood_box.visible = true

	if shop_item.cost_mushroom > 0:
		mushroom_box.visible = true
	
	if shop_item.cost_jewel > 0:
		jewel_box.visible = true
