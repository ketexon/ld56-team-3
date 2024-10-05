class_name AssignRoleButton
extends Button

@export var role: TinyCreature.Role

const ROLE_STRING = "Assign selected Tiny Creatures the %s Role"

func _ready() -> void:
	tooltip_text = ROLE_STRING % TinyCreature.role_name_dict[role]

func _pressed() -> void:
	print("PRESSED")