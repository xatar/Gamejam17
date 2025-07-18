class_name Character
extends CharacterBody3D

@export var health_component: HealthComponent
@export var attack_component: AttackComponent

func _ready() -> void:
	health_component.on_death.connect(_on_death)

func deal_damage(target: CharacterBody3D) -> void:
	attack_component.deal_damage(attack_component.damage, target)

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func heal(amount: float) -> void:
	health_component.heal(amount)

func _on_death() -> void:
	queue_free()
