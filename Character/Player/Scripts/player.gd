class_name Player
extends Character

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var camera: Camera3D

func _unhandled_input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("take_damage"):
		attack_component.deal_damage(10.0, self)
	if Input.is_action_just_pressed("heal"):
		health_component.heal(10.0)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = Vector3(input_dir.x, 0.0, input_dir.y).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)
		
	move_and_slide()
	
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var ray_origin: Vector3 = camera.project_ray_origin(mouse_position)
	var ray_direction: Vector3 = ray_origin + camera.project_ray_normal(mouse_position) * 1000
	var ray_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction)
	
	ray_query.collide_with_bodies = true
	
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var ray_result: Dictionary = space_state.intersect_ray(ray_query)
	
	if !ray_result.is_empty():
		if ray_result.collider != self:
			var target_position: Vector3 = ray_result.position
			target_position.y = global_transform.origin.y
			look_at(target_position)
