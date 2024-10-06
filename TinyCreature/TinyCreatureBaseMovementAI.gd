class_name TinyCreatureBaseMovementAI
extends Node2D

@export var tiny_creature: TinyCreature
@export var idle_duration_min: float = 0.5
@export var idle_duration_max: float = 1.5
@export var moving_duration_min: float = 0.5
@export var moving_duration_max: float = 1.5

static var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var colony: Colony:
	get: return tiny_creature.colony

var enabled: bool:
	set(v):
		if v != enabled:
			enabled = v
			if !enabled:
				t = INF
				state = State.MOVING

enum State {
	IDLE,
	MOVING,
}

var state := State.IDLE

var idle_duration: float
var moving_duration: float
var t: float

func _ready() -> void:
	enabled = true
	transition_to_idle()

func _process(delta: float) -> void:
	if not enabled: return
	match state:
		State.IDLE:
			if t > idle_duration:
				transition_to_move()

		State.MOVING:
			if t > moving_duration:
				transition_to_idle()
	t += delta

func set_random_durations():
	idle_duration = rng.randf_range(idle_duration_min, idle_duration_max)
	moving_duration = rng.randf_range(moving_duration_min, moving_duration_max)

func transition_to_move():
	state = State.MOVING
	t = 0

	var disp_to_monarch = colony.monarch.global_position - global_position
	var dist_to_monarch = disp_to_monarch.length()

	var percent_distance = dist_to_monarch / colony.radius

	tiny_creature.running = percent_distance > 0.5

	var random_angle = rng.randf_range(0, 360)
	var random_dir = Vector2.from_angle(random_angle)

	var dir = lerp(
		random_dir,
		disp_to_monarch.normalized(),
		percent_distance
	)

	tiny_creature.movement_dir = dir

func transition_to_idle():
	set_random_durations()
	state = State.IDLE
	t = 0

	tiny_creature.movement_dir = Vector2.ZERO
