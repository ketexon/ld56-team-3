class_name MapGenerator
extends TileMapLayer

enum Terrain {
	FOREST,
	CAVES,
	SWAMP,
}

@export var bounds: Rect2i

@export var source_id: int = 3
@export var base_terrain_set: int = 2
@export var seed_density: float = 1.0/(16 * 16)
@export var spread_fail_chance: float = 0.01
@export var max_depth: int = 64

@export var wood_resource: PackedScene
@export var mushroom_resource: PackedScene
@export var jewels_resource: PackedScene

@export var rng_seed: String = ""

static var rng = RandomNumberGenerator.new()

func _ready():
	if not rng_seed.is_empty():
		rng.seed = hash(rng_seed)
	generate()

func sample_cell() -> Vector2i:
	return Vector2i(
		rng.randi_range(0, bounds.size.x - 1) + bounds.position.x,
		rng.randi_range(0, bounds.size.y - 1) + bounds.position.y
	)

## algorithm:
## 		Seed map with randomly distributed cells
##		Iterate:
##			BFS with low fail chnace of spreading biome
func generate():
	var base_cells: Array[Vector2i] = []
	for x in range(bounds.position.x, bounds.position.x + bounds.size.x):
		for y in range(bounds.position.y, bounds.position.y + bounds.size.y):
			var coord = Vector2i(x, y)
			set_cell(coord, source_id, Vector2i(0, 0))
			base_cells.append(coord)

	set_cells_terrain_connect(
		base_cells,
		0,
		base_terrain_set
	)


	# index is terrain layer
	# cells[i] is a set
	var cells: Array[Dictionary] = [
		{},
		{},
		{}
	]

	var all_cells: Dictionary = {}

	var unsearched_cells: Array[Vector2i] = []
	var next_unsearched_cells: Array[Vector2i] = []

	var n_seeds := floori(bounds.size.x * bounds.size.y * seed_density)

	for i in n_seeds:
		var terrain_layer = rng.randi_range(0, 2)
		var cell = sample_cell()
		while cell in all_cells:
			cell = sample_cell()
		cells[terrain_layer][cell] = null
		all_cells[cell] = terrain_layer
		unsearched_cells.append(cell)
	var cell_i = 0
	for iter in range(max_depth):
		for cell in unsearched_cells:
			cell_i += 1
			if cell_i > 1000:
				await get_tree().process_frame
				cell_i = 0
			for d in 4:
				var neighbor = cell + Vector2i((d/2), (1 - d/2)) * ((d%2) * 2 - 1)
				if not bounds.has_point(neighbor): continue
				if neighbor not in all_cells and rng.randf() > spread_fail_chance:
					var terrain_layer = all_cells[cell]
					cells[terrain_layer][neighbor] = null
					all_cells[neighbor] = terrain_layer
					next_unsearched_cells.append(neighbor)
		unsearched_cells = next_unsearched_cells.duplicate()
		next_unsearched_cells.clear()

	for i in range(3):
		set_cells_terrain_connect(
			cells[i].keys(),
			0,
			i
		)
	notify_runtime_tile_data_update()
