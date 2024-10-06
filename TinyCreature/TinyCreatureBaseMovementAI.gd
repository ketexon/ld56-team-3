class_name TinyCreatureBaseMovementAI
extends Node2D

@export var tiny_creature: TinyCreature
@export var idle_duration: float
@export var moving_duration: float

var enabled := true

enum State {
	IDLE,
	MOVING,
}

var state := State.MOVING
var t := 0.0

func _process(delta: float) -> void:
	t += delta
	match state:
		State.IDLE:
			if t > idle_duration:
				transition_to_move()
				state = State.MOVING
				t = 0


		State.MOVING:
			# tiny_creature.movement_dir =
			if t > moving_duration:
				state = State.IDLE
				t = 0

func transition_to_move():
	pass