extends Node

signal config_loaded

static var config:ConfigFile = ConfigFile.new()
static var config_path := "user://options.cfg"

func _init() -> void:
	if not FileAccess.file_exists(config_path):
		config.set_value('PlayerColors', 'MainColor', '4C89EE')
		config.set_value('PlayerColors', 'FaceColor', 'B8FFF0')
		config.save(config_path)
	else:
		config.load(config_path)
	config_loaded.emit(config)
