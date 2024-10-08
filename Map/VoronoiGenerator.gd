class_name VoronoiGenerator
extends Node

@export var texture: Texture2DRD
@export var texture_size: Vector2i = Vector2i(512, 512)
@export var n_layers: int = 3
@export var rng_seed: float = 0.0

signal generated

func generate():
	RenderingServer.call_on_render_thread(_run_compute_shader)
	# _run_compute_shader()

func _exit_tree() -> void:
	# Make sure we clean up!
	if texture:
		texture.texture_rd_rid = RID()

	RenderingServer.call_on_render_thread(free_resources)


###############################################################################
# Everything after this point is designed to run on our rendering thread.

var rd: RenderingDevice

var shader: RID
var pipeline: RID

var texture_rd: RID = RID()
var texture_set: RID = RID()

func _create_uniform_set() -> RID:
	var uniform := RDUniform.new()
	uniform.uniform_type = RenderingDevice.UNIFORM_TYPE_IMAGE
	uniform.binding = 0
	uniform.add_id(texture_rd)
	return rd.uniform_set_create([uniform], shader, 0)


func _run_compute_shader() -> void:
	# As this becomes part of our normal frame rendering,
	# we use our main rendering device here.
	rd = RenderingServer.get_rendering_device()

	# Create our shader.
	var shader_file := load("res://Map/voronoi.glsl")
	var shader_spirv: RDShaderSPIRV = shader_file.get_spirv()
	shader = rd.shader_create_from_spirv(shader_spirv)
	pipeline = rd.compute_pipeline_create(shader)

	var tf: RDTextureFormat = RDTextureFormat.new()
	tf.format = RenderingDevice.DATA_FORMAT_R32_SFLOAT
	tf.texture_type = RenderingDevice.TEXTURE_TYPE_2D
	tf.width = texture_size.x
	tf.height = texture_size.y
	tf.depth = 1
	tf.array_layers = 1
	tf.mipmaps = 1
	tf.usage_bits = (
			RenderingDevice.TEXTURE_USAGE_SAMPLING_BIT |
			RenderingDevice.TEXTURE_USAGE_COLOR_ATTACHMENT_BIT |
			RenderingDevice.TEXTURE_USAGE_STORAGE_BIT |
			RenderingDevice.TEXTURE_USAGE_CAN_UPDATE_BIT |
			RenderingDevice.TEXTURE_USAGE_CAN_COPY_FROM_BIT
	)

	texture_rd = rd.texture_create(tf, RDTextureView.new(), [])
	if texture:
		texture.texture_rd_rid = texture_rd

	texture_set = _create_uniform_set()

	_render_to_texture()


func _render_to_texture() -> void:
	var push_constant := PackedFloat32Array()
	push_constant.push_back(texture_size.x)
	push_constant.push_back(texture_size.y)
	push_constant.push_back(16.0)
	push_constant.push_back(16.0)
	push_constant.push_back(n_layers)
	push_constant.push_back(rng_seed)
	push_constant.push_back(0.0)
	push_constant.push_back(0.0)

	# Calculate our dispatch group size.
	# We do `n - 1 / 8 + 1` in case our texture size is not nicely
	# divisible by 8.
	# In combination with a discard check in the shader this ensures
	# we cover the entire texture.
	@warning_ignore("integer_division")
	var x_groups := (texture_size.x - 1) / 8 + 1
	@warning_ignore("integer_division")
	var y_groups := (texture_size.y - 1) / 8 + 1

	# Run our compute shader.
	var compute_list := rd.compute_list_begin()
	rd.compute_list_bind_compute_pipeline(compute_list, pipeline)
	rd.compute_list_bind_uniform_set(compute_list, texture_set, 0)
	rd.compute_list_set_push_constant(compute_list, push_constant.to_byte_array(), push_constant.size() * 4)
	rd.compute_list_dispatch(compute_list, x_groups, y_groups, 1)
	rd.compute_list_end()
	rd.submit()
	rd.sync()
	generated.emit()

func free_resources() -> void:
	if not rd: return
	rd.free_rid(texture_rd)
	if shader:
		rd.free_rid(shader)
