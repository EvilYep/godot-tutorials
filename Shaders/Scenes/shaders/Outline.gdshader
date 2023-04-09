shader_type canvas_item;

uniform float stroke : hint_range(0.0, 30.0);
uniform vec4 outline_color : source_color;

void fragment() {
	float width = stroke * 1.0 / float(textureSize(TEXTURE, 0).x);
	float height = stroke * 1.0 / float(textureSize(TEXTURE, 0).y);
	
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	//float alpha = -8.0 * sprite_color.a;
	
	
	alpha += texture(TEXTURE, UV + vec2(width, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-width, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, height)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -height)).a;

//	to enable diagonals uncomment this and edit above (-8.0 instead of -4.0)
//	alpha += texture(TEXTURE, UV + vec2(width, height)).a;
//	alpha += texture(TEXTURE, UV + vec2(-width, height)).a;
//	alpha += texture(TEXTURE, UV + vec2(width, height)).a;
//	alpha += texture(TEXTURE, UV + vec2(width, -height)).a;
	
	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
}
