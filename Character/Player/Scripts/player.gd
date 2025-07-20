class_name Player
extends CharacterBody3D

var attack_component: AttackComponent
var health_component: AttackComponent

var current_speed: float = 5.0

const walking_speed = 5.0
const running_speed = 8.0
const dash_speed = 15.0
const dash_duration = 0.2
const dash_cooldown = 1.0
const dash_cooldown_left = 0.0

const mouse_sens = 0.3
const controller_sens = 2.5
const jump_velocity = 10.0
const player_gravity = -25.0

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var camera: Camera3D = $Camera3D

var camera_x_rotation: float = 0.0
var dash_time_left: float = 0.0
var is_dashing: bool = true
var jump_count: int = 0 

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	attack_component = $AttackComponent
	#health_component = $HealthComponent

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("dash_sprint") and dash_cooldown_left <= 0.0:
		start_dash()
	
	if Input.is_action_just_pressed("take_damage"):
		attack_component.deal_damage(10.0, self)
	if Input.is_action_just_pressed("heal"):
		health_component.heal(10.0)




func start_dash() -> void:
	is_dashing = true
	dash_time_left = dash_duration
	current_speed = dash_speed
