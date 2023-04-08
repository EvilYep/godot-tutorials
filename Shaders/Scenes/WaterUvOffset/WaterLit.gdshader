shader_type canvas_item;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform sampler2D uv_offset_texture: hint_default_black, repeat_enable;
uniform vec2 uv_offset_size = vec2(1.0, 1.0);
uniform vec2 waves_size = vec2(0.1, 0.15);
uniform vec2 time_scale = vec2(0.05, 0.08);

void fragment() {
	vec2 base_uv_offset = UV * uv_offset_size;
	base_uv_offset += TIME * time_scale;
	
	vec2 texture_based_offset = texture(uv_offset_texture, base_uv_offset).rg;
	texture_based_offset = texture_based_offset * 2.0 - 1.0;
	texture_based_offset *= waves_size;
	
	vec2 adjusted_uv = UV * tile_factor;
	adjusted_uv.y *= aspect_ratio;
	
	COLOR = texture(TEXTURE, adjusted_uv + texture_based_offset);
	//COLOR = vec4(texture_based_offset, vec2(0.0, 1.0));
	
	NORMAL_MAP = texture(NORMAL_TEXTURE, UV + texture_based_offset * 0.5).rgb;
}
