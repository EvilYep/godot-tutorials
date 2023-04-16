shader_type canvas_item;

uniform float screen_height = 648.0;

void fragment() {
	int y_index = int(UV.y * screen_height * 0.25 - TIME * 3.0);
	if (y_index % 3 == 0) {
		COLOR.a = 0.1;
	} else {
		COLOR.a = 0.0;
	}
}
