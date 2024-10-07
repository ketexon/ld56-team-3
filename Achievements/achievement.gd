class_name Achievement
extends Node2D

# Achievements have a type: one for each type, funny ones, dev ones, 
# and the achievements about other achievements
enum ACHIEVEMENT_TYPE {POWER, PERSUASION, REPUTATION, FUNNY, DEV, META}
var achievementName : String
var type : ACHIEVEMENT_TYPE



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Constructor

func _init(title := "debug", cat = ACHIEVEMENT_TYPE.FUNNY):
	achievementName = title
	type = cat
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
