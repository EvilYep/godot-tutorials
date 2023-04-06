shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	//vec4 c_white = vec4(base_color.r * 2.0, base_color.g * 2.0, base_color.b * 2.0, base_color.a);
	vec4 c_white = vec4(1.0, 1.0, 1.0, base_color.a);
	vec4 flash_color = base_color * float(!active) + c_white * float(active);
	COLOR = flash_color;
}
