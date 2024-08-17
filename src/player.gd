extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var look_dir = Vector2.UP

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_front", "walk_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity.x = lerp(velocity.x, direction.x * SPEED, 0.10 * 60 * delta)
	velocity.z = lerp(velocity.z, direction.z * SPEED, 0.10 * 60 * delta)

	move_and_slide()
	if input_dir:
		$Model.rotation.y = lerp_angle(
			$Model.rotation.y,
			-PI/2.0-input_dir.angle(),
			0.2 * 60 * delta
		)
	
	$Model/AnimationPlayer.play("walk" if Vector2(velocity.x,velocity.z).length() > 0.1 and input_dir else "idle")
