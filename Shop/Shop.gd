class_name Shop
extends Control

static var instance: Shop

func _ready():
	instance = self
	visible = false
