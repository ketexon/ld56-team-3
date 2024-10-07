extends Sprite2D

@export var tiny_creature: TinyCreature

@export var warrior_hat: Texture2D
@export var lumberjack_hat: Texture2D
@export var forager_hat: Texture2D
@export var miner_hat: Texture2D
@export var monarch_hat: Texture2D
@export var ambassador_hat: Texture2D
@export var royal_hat: Texture2D

var last_role := TinyCreature.Role.UNASSIGNED

func _process(delta):
	if tiny_creature.role != last_role:
		_update_hat()

func _update_hat():
	visible = true
	match tiny_creature.role:
		TinyCreature.Role.UNASSIGNED:
			visible = false
		TinyCreature.Role.MONARCH:
			texture = monarch_hat
		TinyCreature.Role.WARRIOR:
			texture = warrior_hat
		TinyCreature.Role.LUMBERJACK:
			texture = lumberjack_hat
		TinyCreature.Role.FORAGER:
			texture = forager_hat
		TinyCreature.Role.MINER:
			texture = miner_hat
		TinyCreature.Role.AMBASSADOR:
			texture = ambassador_hat
		TinyCreature.Role.ROYAL:
			texture = royal_hat