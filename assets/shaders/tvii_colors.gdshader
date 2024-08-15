shader_type canvas_item;

uniform vec3 main_color;
uniform vec3 face_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float is_red = max(floor(COLOR.r-(COLOR.g+COLOR.b)/2.0),0);
	float is_blue = max(floor(COLOR.b-(COLOR.r+COLOR.g)/2.0),0);
	COLOR = vec4(
		main_color*is_red+
		face_color*is_blue+
		COLOR.rgb-vec3(is_red,0,0)-vec3(0,0,is_blue),
		COLOR.a
	);
}
