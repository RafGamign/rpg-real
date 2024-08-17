extends Node2D

@export var player:Player = null

func _ready() -> void:
	$MainColor.color = Color.from_string(Options.config.get_value("PlayerColors", "MainColor"), Color.from_hsv(217, 68, 93))
	$FaceColor.color = Color.from_string(Options.config.get_value("PlayerColors", "FaceColor"), Color.from_hsv(167, 27, 100))
	if player != null:
		player.lock_movement = true

func _on_main_color_color_changed(color: Color) -> void:
	Options.config.set_value("PlayerColors", "MainColor", color.to_html())
	if player != null:
		player.update_colors()

func _on_face_color_color_changed(color: Color) -> void:
	Options.config.set_value("PlayerColors", "FaceColor", color.to_html())
	if player != null:
		player.update_colors()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Options.config.save(Options.config_path)
		if player != null:
			player.update_colors()
			player.lock_movement = false
		get_parent().remove_child(self)
