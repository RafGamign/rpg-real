class_name InteractPrompt
extends Node3D

@export var prompt_height:float = 1
@export var interaction_radius:float = 3

@onready var area:Area3D = Area3D.new()
@onready var collision_shape:CollisionShape3D = CollisionShape3D.new()
@onready var prompt_text:Label3D = Label3D.new()

func _ready() -> void:
	get_parent().add_child.call_deferred(area)
	area.add_child(collision_shape)
	add_child(prompt_text)
	
	collision_shape.shape = SphereShape3D.new()
	collision_shape.shape.radius = interaction_radius
	
	prompt_text.position.y += prompt_height
	prompt_text.font = load("res://assets/fonts/COMICORO.TTF")
	prompt_text.font_size = 90
	prompt_text.text = "customize :3c [E]"
	prompt_text.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	prompt_text.visible = false
	
	area.connect('body_entered', body_entered)
	area.connect('body_exited', body_exited)

func body_entered(body:Node3D) -> void:
	if body.name == "Player":
		prompt_text.visible = true

func body_exited(body:Node3D) -> void:
	if body.name == "Player":
		prompt_text.visible = false

func _process(delta: float) -> void:
	pass
