class_name Player
extends CharacterBody3D

var attack_component: AttackComponent
var health_component: AttackComponent

var current_speed: float = 5.0

const walking_speed: float = 5.0
const running_speed: float = 8.0
const dash_speed: float = 15.0
const dash_duration: float = 0.2
const dash_cooldown: float = 1.0
const max_jumps: int = 2

var dash_cooldown_left: float = 0.0
var mouse_sens: float = 0.3
var controller_sens: float = 2.5
var jump_velocity: float = 10.0
var player_gravity: float = -25.0

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var camera: Camera3D = $Camera3D

var camera_x_rotation: float = 0.0
var dash_time_left: float = 0.0
var is_dashing: bool = true
var jump_count: int = 0 

#var input_direction: Vector3 
#var direction: Vector3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	attack_component = $AttackComponent
	#health_component = $HealthComponent

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sens
		camera_x_rotation -= event.relative.y * mouse_sens
		camera_x_rotation = clamp(camera_x_rotation, -50, 50)
		camera.rotation_degrees.x = camera_x_rotation

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("dash_sprint") and dash_cooldown_left <= 0.0:
		start_dash()
	
	if Input.is_action_just_pressed("take_damage"):
		attack_component.deal_damage(10.0, self)
	if Input.is_action_just_pressed("heal"):
		health_component.heal(10.0)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += player_gravity * delta
	else:
		jump_count = 0
	if Input.is_action_just_pressed("jump"):
		jump()
		
	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			end_dash()
	else:
		if Input.is_action_just_pressed("dash_sprint") and dash_cooldown_left <= 0.0:
			current_speed = running_speed
		else:
			current_speed = walking_speed
			dash_cooldown_left -= delta
	
	var input_direction: Vector2 = Input.get_vector("move_backward","move_forward","move_left","move_right")
	var direction: Vector3 = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	move_and_slide()


func start_dash() -> void:
	is_dashing = true
	dash_time_left = dash_duration
	current_speed = dash_speed

func end_dash() -> void:
	is_dashing = false
	current_speed = running_speed

func jump() -> void:
	if jump_count < max_jumps:
		velocity.y = jump_velocity
		jump_count += 1
