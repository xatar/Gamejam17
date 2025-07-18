class_name Player
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_component: AttackComponent


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("take_damage"):
		attack_component.deal_damage(10.0, self)
	if Input.is_action_just_pressed("heal"):
		health_component.heal(10.0)
