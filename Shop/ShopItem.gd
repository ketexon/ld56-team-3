class_name ShopItem
extends Resource

@export var name: String
@export var texture: Texture2D

@export var cost_wood: int
@export var cost_mushroom: int
@export var cost_jewel: int

@export var min_power: int
@export var min_persuasion: int
@export var min_reputation: int

@export var delta_power: int
@export var delta_persuasion: int
@export var delta_reputation: int

@export var mult_power: int = 1
@export var mult_persuasion: int = 1
@export var mult_reputation: int = 1 

@export var mult_attack: int = 1
@export var mult_speed: int = 1
@export var mult_health: int = 1