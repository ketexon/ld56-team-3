extends Node2D

# Variables tracking achievement progress
var completedAchievements : int = 0
var powerAchievements : int = 0
var persuasionAchievements : int = 0
var reputationAchievements : int = 0
var funnyAchievements : int = 0
var devAchievements : int = 0

# Signals
signal achieved(name)

# Achievement Unlock Function
func achievementGet(achievement : String) -> void:
	achieved.emit(achievement)

# Displays UI for an Achivement Unlock
func displayAchievement(achievement : String) -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_node("Timer")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player_colony.power == 10):
		pass


func _on_signal_test_pressed() -> void:
	achieved.emit("name")
