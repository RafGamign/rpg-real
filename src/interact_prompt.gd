class_name InteractPrompt
extends Node3D

signal interact
signal prompt_show
signal prompt_hide

@export var prompt_height:float = 1
@export var interaction_radius:float = 3

@onready var area:Area3D = Area3D.new()
@onready var collision_shape:CollisionShape3D = CollisionShape3D.new()
@onready var prompt_text:Label3D = Label3D.new()

var showing_prompt:bool = false:
	get:
		return showing_prompt
	set(v):
		showing_prompt = v
		if last_body != null and last_body.name == "Player":
			prompt_text.visible = showing_prompt

var last_body:Node3D = null

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
	last_body = body
	_show_prompt()

func body_exited(body:Node3D) -> void:
	last_body = body
	_hide_prompt()

func _show_prompt() -> void:
	showing_prompt = true
	prompt_show.emit()

func _hide_prompt() -> void:
	showing_prompt = false
	prompt_hide.emit()

func _process(_delta: float) -> void:
	if showing_prompt and Input.is_action_just_pressed("interact"):
		_hide_prompt()
		interact.emit()
