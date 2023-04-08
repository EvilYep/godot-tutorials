shader_type canvas_item;

uniform vec4 shadow_color: source_color;

uniform vec2 tiled_factor = vec2(10.0, 10.0);
uniform float aspect_ratio = 0.5;

uniform sampler2D uv_offset_texture: hint_default_black, repeat_enable;
uniform vec2 uv_offset_size = vec2(1.0, 1.0);
uniform vec2 uv_offset_waves_size = vec2(0.1, 0.1);
uniform float uv_offset_time_scale = 0.05;

uniform vec2 sine_amplitude = vec2(0.05, 0.1);
uniform vec2 sine_offset_scale = vec2(5.0, 2.0);
uniform vec2 sine_time_scale = vec2(1.0, 1.0);

vec2 get_waves_offset(vec2 tiled_uvs) {
	return vec2(cos(TIME * sine_time_scale.x + (tiled_uvs.x + tiled_uvs.y) * sine_offset_scale.x),
			sin(TIME * sine_time_scale.y + (tiled_uvs.x + tiled_uvs.y) * sine_offset_scale.y));
}

void fragment() {
	vec2 base_uv_offset = UV * uv_offset_size;
	base_uv_offset += TIME * uv_offset_time_scale;
	
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 texture_based_offset = texture(uv_offset_texture, base_uv_offset).rg * uv_offset_waves_size * 2.0 - 1.0;
	vec2 waves_uv_offset = get_waves_offset(tiled_uvs);
	vec2 waves_uv = tiled_uvs + texture_based_offset + waves_uv_offset * sine_amplitude;
	
	float waves_height = (texture_based_offset.y * 0.5 + waves_uv_offset.y) * 0.25 + 0.5;
	
	vec4 diffuse_color = texture(TEXTURE, waves_uv);
	COLOR = mix(diffuse_color, diffuse_color * shadow_color, waves_height);
	//COLOR = vec4(waves_height, waves_height, waves_height, 1.0);
	NORMAL_MAP = texture(NORMAL_TEXTURE, waves_uv / 5.0).rgb;
}