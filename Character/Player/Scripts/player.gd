class_name Player
extends CharacterBody3D

var attack_component: AttackComponent
var health_component: AttackComponent

func _ready() -> void:
	attack_component = $AttackComponent
	#health_component = $HealthComponent

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("take_damage"):
		attack_component.deal_damage(10.0, self)
	if Input.is_action_just_pressed("heal"):
		health_component.heal(10.0)


#extends CharacterBody3D
#
#var current_speed = 5.0
#
#const walking_speed = 5.0
#const running_speed = 8.0
#const crouch_speed = 3.0
#const dash_speed = 15.0
#const dash_duration = 0.2
#const dash_cooldown = 1.0
#
#const mouse_sens = 0.3
#const controller_sens = 2.5
#const jump_velocity = 10.0
#const player_gravity = -25.0
#
#const max_jumps = 2
#
#var can_shoot = true
#var dead = false
#var is_dashing = false
#var dash_time_left = 0.0
#var dash_cooldown_left = 0.0
#var jump_count = 0 
#
#@onready var animated_sprite_2d = $Camera3D/CanvasLayer/GunBase/AnimatedSprite2D
#@onready var ray_cast_3d = $RayCast3D
#@onready var gun_sound = $GunSound
#@onready var camera = $Camera3D
#
#var camera_x_rotation = 0.0 
#
#func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	#$Camera3D/CanvasLayer/DeathScreen/Panel/Button.button_up.connect(startover)
#
#func _input(event):
	#if dead:
		#return
	#if event is InputEventMouseMotion:
		## Horizontal rotation (yaw) with mouse
		#rotation_degrees.y -= event.relative.x * mouse_sens
		## Vertical rotation (pitch) with mouse
		#camera_x_rotation -= event.relative.y * mouse_sens
		#camera_x_rotation = clamp(camera_x_rotation, -90, 90)  # Limit vertical rotation to avoid flipping
		#camera.rotation_degrees.x = camera_x_rotation
#
#func _process(delta):
	#if Input.is_action_just_pressed("exit"):
		#get_tree().quit()
	#if Input.is_action_just_pressed("startover"):
		#startover()
#
	#if dead:
		#return
	#if Input.is_action_just_pressed("shoot"):
		#shoot()
#
	#if Input.is_action_just_pressed("sprint") and dash_cooldown_left <= 0.0:
		#start_dash()
#
#func _physics_process(delta):
	#if not is_on_floor():
		#velocity.y += player_gravity * delta
	#else:
		#jump_count = 0
#
	#if Input.is_action_just_pressed("jump"):
		#jump()
#
	#if is_dashing:
		#dash_time_left -= delta
		#if dash_time_left <= 0:
			#end_dash()
	#else:
		#if Input.is_action_pressed("sprint") and dash_cooldown_left <= 0.0:
			#current_speed = running_speed
		#else:
			#current_speed = walking_speed
#
		#dash_cooldown_left -= delta  #Reduce the cooldown timer
#
	#var input_dir = Input.get_vector("left", "right", "forward", "backward")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#
	#if direction:
		#velocity.x = direction.x * current_speed
		#velocity.z = direction.z * current_speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, current_speed)
		#velocity.z = move_toward(velocity.z, 0, current_speed)
#
	##  Console (xbox/psn) controller input for camera movement
	#var right_stick_x = Input.get_axis("right_stick_left", "right_stick_right")
	#var right_stick_y = Input.get_axis("right_stick_up", "right_stick_down")
#
	## Horizontal rotation (yaw) with controller
	#rotation_degrees.y -= right_stick_x * controller_sens
	## Vertical rotation (pitch) with controller
	#camera_x_rotation -= right_stick_y * controller_sens
	#camera_x_rotation = clamp(camera_x_rotation, -90, 90)  # Limit vertical rotation to avoid flipping
	#camera.rotation_degrees.x = camera_x_rotation
#
	#move_and_slide()
#
#func start_dash():
	#is_dashing = true
	#dash_time_left = dash_duration
	#current_speed = dash_speed
#
#func end_dash():
	#is_dashing = false
	#current_speed = running_speed
#
#func jump():
	#if jump_count < max_jumps:
		#velocity.y = jump_velocity
		#jump_count += 1
#
#func startover():
	#get_tree().reload_current_scene()
#
#func shoot():
	#if !can_shoot:
		#return
	#can_shoot = false
	#animated_sprite_2d.play("shoot")
	#gun_sound.play()
#
	#var ray_origin = camera.global_transform.origin
	#ray_cast_3d.global_transform.origin = ray_origin
	#ray_cast_3d.global_transform.basis = camera.global_transform.basis
#
	#ray_cast_3d.enabled = true
	#ray_cast_3d.force_raycast_update()
#
	#if ray_cast_3d.is_colliding():
		#var collider = ray_cast_3d.get_collider()
		#print("Colliding with:", collider)
		#if collider and collider.has_method("kill"):
			#collider.kill()
	#else:
		#print("No collision detected")
#
	#ray_cast_3d.enabled = false
#
#func shoot_anim_done():
	#can_shoot = true
#
#func kill():
	#dead = true
	#$Camera3D/CanvasLayer/DeathScreen.show()
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
