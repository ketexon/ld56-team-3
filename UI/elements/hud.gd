extends Control

@onready var power_label: Label = %PowerLabel
@onready var persuasion_label: Label = %PersuasionLabel
@onready var reputation_label: Label = %ReputationLabel

@onready var wood_label: Label = %WoodLabel
@onready var mushrooms_label: Label = %MushroomsLabel
@onready var jewels_label: Label = %JewelsLabel

@onready var shop_button: Button = %ShopButton

func _ready():
	shop_button.button_down.connect(_open_shop)

func _open_shop():
	Shop.instance.visible = not Shop.instance.visible

func _process(_delta):
	power_label.text = "%d" % Colony.player_colony.power
	persuasion_label.text = "%d" % Colony.player_colony.persuasion
	reputation_label.text = "%d" % Colony.player_colony.reputation

	wood_label.text = "%d" % Colony.player_colony.wood
	mushrooms_label.text = "%d" % Colony.player_colony.mushrooms
	jewels_label.text = "%d" % Colony.player_colony.jewels
