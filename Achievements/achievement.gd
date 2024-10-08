class_name Achievement
extends Node2D

# Achievements have a type: one for each type, funny ones, dev ones, 
# and the achievements about other achievements
enum ACHIEVEMENT_TYPE {POWER, PERSUASION, REPUTATION, FUNNY, DEV, META}
var achievementName : String
var type : ACHIEVEMENT_TYPE


# Constructor
func _init(title := "debug", cat = ACHIEVEMENT_TYPE.FUNNY):
	achievementName = title
	type = cat
