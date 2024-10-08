class_name Colony
extends Node2D

@export var player: bool = false

@export var start_tiny_creatures: int = 32
@export var tiny_creature_prefab: PackedScene

@onready var visibility_area: Area2D = %VisibilityArea
@onready var colony_ui : Control = %ColonyUI

@export var available_shop_items: Array[ShopItem]

@export var power: int = 0
@export var persuasion: int = 0
@export var reputation: int = 0

@export var wood: int
@export var mushrooms: int
@export var jewels: int

signal resource_visibility_changed(resource: GResource, visible: bool)

var tiny_creatures: Array[TinyCreature] = []
var monarch: TinyCreature = null
var visible_resources: Dictionary = {
	GResource.Type.WOOD: [],
	GResource.Type.MUSHROOMS: [],
	GResource.Type.JEWELS: [],
}

var radius: float:
	get:
		var n = len(tiny_creatures)
		# return 32 * pow(1.5, n)
		return calc_radius(n)

func calc_radius(n: int) -> float:
	return 32 * sqrt(n)

static var player_colony: Colony

static var rng := RandomNumberGenerator.new()

func _ready() -> void:
	if player:
		player_colony = self
		colony_ui.visible = false

	var start_radius := calc_radius(start_tiny_creatures)

	monarch = add_tiny_creature(Vector2.ZERO, TinyCreature.Role.MONARCH)

	for i in range(start_tiny_creatures - 1):
		var angle := rng.randf_range(0, 360)
		# NOTE: this isn't uniform sampling, but is more denser to the middle
		# (which is what we want)
		var r := start_radius * rng.randf()
		var vec := Vector2.from_angle(angle) * r

		add_tiny_creature(vec)

	visibility_area.body_entered.connect(_body_entered_visibility)
	visibility_area.body_exited.connect(_body_exited_visibility)

func add_tiny_creature(pos: Vector2, role: TinyCreature.Role = TinyCreature.Role.UNASSIGNED) -> TinyCreature:
	var tiny_creature := tiny_creature_prefab.instantiate() as TinyCreature

	tiny_creature.role = role
	tiny_creature.colony = self
	tiny_creature.position = pos

	add_child(tiny_creature)
	tiny_creatures.push_back(tiny_creature)

	return tiny_creature


func add_resource(type: GResource.Type):
	match type:
		GResource.Type.WOOD: wood += 1
		GResource.Type.MUSHROOMS: mushrooms += 1
		GResource.Type.JEWELS: jewels += 1
		_: assert(false)


func _physics_process(delta: float) -> void:
	visibility_area.global_position = monarch.global_position


func _body_entered_visibility(body: Node2D):
	if body.is_in_group(&"resources") and body is GResource:
		visible_resources[body.type].push_back(body)
		body.tree_exiting.connect(_on_resource_exiting_tree, CONNECT_ONE_SHOT)
		resource_visibility_changed.emit(body, true)


func _body_exited_visibility(body: Node2D):
	if body.is_in_group(&"resources"):
		visible_resources[body.type].erase(body)
		body.tree_exiting.disconnect(_on_resource_exiting_tree)
		resource_visibility_changed.emit(body, false)

func _on_resource_exiting_tree(res: GResource):
	visible_resources[res.type].erase(res)
	resource_visibility_changed.emit(res, false)


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

# debugging signals quickly
var debugAch : Achievement = Achievement.new("debug",Achievement.ACHIEVEMENT_TYPE.POWER)
# Button Presses
func _on_action_1_pressed() -> void:
	print("Action 1")
	AchievementManager.achieved.emit(debugAch)
func _on_action_2_pressed() -> void:
	print("Action 2")
func _on_action_3_pressed() -> void:
	print("Action 3")
func _on_action_4_pressed() -> void:
	print("Action 4")
func _on_action_5_pressed() -> void:
	print("Action 5")

func _process(delta: float) -> void:

	# Enemy Colony's UI follows its monarch
	if !player:
		colony_ui.global_position = monarch.global_position
		# Zooming in too far hides colony UI
		if CameraControls.viewing_colony:
			colony_ui.visible = true
		elif !CameraControls.viewing_colony:
			colony_ui.visible = false
