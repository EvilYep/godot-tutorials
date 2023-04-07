shader_type canvas_item;

uniform float speed = 1.0;
uniform vec2 amplitude = vec2(10.0, 5.0);

void vertex() {
	VERTEX.x += cos(speed * TIME + VERTEX.x + VERTEX.y) * amplitude.x;
	VERTEX.y += sin(speed * TIME + VERTEX.y + VERTEX.x) * amplitude.y;
}

void fragment() {
	
}
