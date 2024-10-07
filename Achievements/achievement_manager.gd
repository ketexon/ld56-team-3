extends Node2D

# Make this an autoload later, future Caleb


# Variables tracking achievement progress
var completedAchievements : int = 0
var powerAchievements : int = 0
var persuasionAchievements : int = 0
var reputationAchievements : int = 0
var funnyAchievements : int = 0
var devAchievements : int = 0
var metaAchievements : int = 0

# Signals
signal achieved(achievement : Achievement)

# Achievement Unlock Function
func achievementGet(achievement : Achievement) -> void:
	completedAchievements += 1
	
	if (achievement.ACHIEVEMENT_TYPE.POWER):
		powerAchievements += 1
	elif (achievement.ACHIEVEMENT_TYPE.PERSUASION):
		persuasionAchievements += 1
	elif (achievement.ACHIEVEMENT_TYPE.REPUTATION):
		reputationAchievements += 1
	elif (achievement.ACHIEVEMENT_TYPE.FUNNY):
		funnyAchievements += 1
	elif (achievement.ACHIEVEMENT_TYPE.DEV):
		devAchievements += 1
	elif (achievement.ACHIEVEMENT_TYPE.META):
		metaAchievements += 1

# Displays UI for an Achivement Unlock
func displayAchievement(achievement : Achievement) -> void:
	pass


func _on_signal_test_pressed() -> void:
	achieved.emit("name")
	
# Signal Calling Method
func _on_achieved(achievement: Achievement) -> void:
	achievementGet(achievement)
	displayAchievement(achievement)
	
