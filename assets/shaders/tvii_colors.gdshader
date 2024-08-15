shader_type canvas_item;

uniform vec3 main_color;
uniform vec3 face_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR.r == 76.0/255.0 && COLOR.g == 137.0/255.0 && COLOR.b == 238.0/255.0) {
		COLOR = vec4(main_color, COLOR.a);
	} if (COLOR.r == 184.0/255.0 && COLOR.g == 255.0/255.0 && COLOR.b == 240.0/255.0) {
		COLOR = vec4(face_color, COLOR.a);
	}
}
