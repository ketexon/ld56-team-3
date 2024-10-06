extends Control

# Stats to be displayed
@export var Power : int
@export var Persuasion : int
@export var Reputation : int

# Colony Monarch Icon?
@export var ColonyIcon : Texture2D

# updating labels
func update_power(number : int):
	%powerLab.text = "Power: " + str(number)
func update_pers(number : int):
	%persuasionLab.text = "Power: " + str(number)
func update_rep(number : int):
	%reputationLab.text = "Power: " + str(number)

var powerDebug = 0
