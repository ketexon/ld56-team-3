#[compute]
#version 450

// Invocations in the (x, y, z) dimension.
layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;

// Our textures.
layout(r32f, set = 0, binding = 0) uniform restrict writeonly image2D output_image;

// Our push PushConstant.
layout(push_constant, std430) uniform Params {
	vec2 texture_size;
	vec2 cell_dim;
	float layers;
	float seed;
} params;

vec2 random(vec2 p){
	p = vec2(
		dot(p, vec2(127.1, 311.7)),
		dot(p, vec2(269.5, 183.3))
	);
	return fract(sin(p) * (43758.5453 + params.seed));
}

float voronoi(vec2 uv, float columns, float rows) {
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));

	float minimum_dist = 1.0;
	vec2 minimum_point;

	for (int y = -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);

			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);

			if(dist < minimum_dist) {
				minimum_dist = dist;
				minimum_point = point;
			}
		}
	}
	return floor(minimum_point.x * params.layers) / params.layers;
}

// The code we want to execute in each invocation.
void main() {
	ivec2 tl = ivec2(0, 0);
	ivec2 size = ivec2(params.texture_size.x - 1, params.texture_size.y - 1);

	ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

	// Just in case the texture size is not divisable by 8.
	if ((uv.x > size.x) || (uv.y > size.y)) {
		return;
	}

	vec2 percent_uv = vec2(float(uv.x) / size.x, float(uv.y) / size.y);

	vec4 result = vec4(voronoi(percent_uv, params.cell_dim.x, params.cell_dim.y).r, 0, 0, 0);

	imageStore(output_image, uv, result);
}