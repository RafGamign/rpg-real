class_name PlayerCamera
extends Camera3D

@export var follow:CharacterBody3D
@export var position_offset:Vector3 = Vector3(0, 3, 4)
@export var rotation_offset:Vector3 = Vector3(12.15, 0, 0)
@export var lerp_value:float = 0.20

var lock:Dictionary = {
	enabled = false,
	position = Vector3(0, 0, 0),
	rotation = Vector3(0, 0, 0),
	fov = 0
}

func _process(delta: float) -> void:
	if not lock.enabled:
		position = lerp(position, follow.position + follow.velocity*Vector3(1,0,1)*delta*16 + position_offset, lerp_value * 60 * delta)
		rotation = lerp(rotation, rotation_offset, lerp_value * 60 * delta)
	else:
		position = lerp(position, lock.position, lerp_value * 60 * delta)
		rotation = lerp(rotation, lock.rotation, lerp_value * 60 * delta)
