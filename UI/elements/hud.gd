extends Control

# Stats to be displayed
@export var Power : Label
@export var Persuasion : Label
@export var Reputation : Label

# updating labels
func update_power(number : int):
	%powerLab.text = "Power: " + str(number)
func update_pers(number : int):
	%persuasionLab.text = "Power: " + str(number)
func update_rep(number : int):
	%reputationLab.text = "Power: " + str(number)

var powerDebug = 0

func _on_add_power_pressed() -> void:
	powerDebug += 1
	update_power(powerDebug)
