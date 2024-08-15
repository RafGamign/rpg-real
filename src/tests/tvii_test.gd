extends Node2D

func _ready() -> void:
	$TviiTest.material.set_shader_parameter('main_color', Color.from_string('4c89ee', Color.BLACK))
	$TviiTest.material.set_shader_parameter('face_color', Color.from_string('b8fff0', Color.BLACK))

func _main_color_changed(color: Color) -> void:
	$TviiTest.material.set_shader_parameter('main_color', color)

func _face_color_changed(color: Color) -> void:
	$TviiTest.material.set_shader_parameter('face_color', color)
