class_name Player
extends CharacterBody3D

@export var lock_movement:bool = false
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var look_dir = Vector2.UP

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	$Model/Node/root/Head/face.mesh.surface_set_material(0,
	$Model/Node/root/Head/face.mesh.surface_get_material(0).duplicate())
	update_colors()

func update_colors() -> void:
	$Model/Node/root/Head/face.mesh.surface_get_material(0).albedo_color = Color.from_string(Options.config.get_value("PlayerColors", "MainColor"), Color.WHITE)
	$Model/Node/root/Head/face.mesh.surface_get_material(0).emission = $Model/Node/root/Head/face.mesh.surface_get_material(0).albedo_color
	$Model/Node/root/Head/face/SpotLight3D.light_color = $Model/Node/root/Head/face.mesh.surface_get_material(0).emission
	$Model/Node/root/Head/face/Label3D.modulate = Color.from_string(Options.config.get_value("PlayerColors", "FaceColor"), Color.BLACK)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if not lock_movement:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var input_dir = Input.get_vector("walk_left", "walk_right", "walk_front", "walk_back")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
		velocity.x = lerp(velocity.x, direction.x * SPEED, 0.10 * 60 * delta)
		velocity.z = lerp(velocity.z, direction.z * SPEED, 0.10 * 60 * delta)

		if input_dir:
			look_dir = input_dir
		$Model/AnimationPlayer.play("walk" if Vector2(velocity.x,velocity.z).length() > 0.1 and input_dir else "idle")
	
		$Model.rotation.y = lerp_angle(
			$Model.rotation.y,
			-PI/2.0-look_dir.angle(),
			0.2 * 60 * delta
		)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.10 * 60 * delta)
		velocity.z = lerp(velocity.z, 0.0, 0.10 * 60 * delta)
	
	move_and_slide()
	
