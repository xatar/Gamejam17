class_name AttackComponent
extends Node

@export var damage: float = 10.0

func deal_damage(amount: float, actor: CharacterBody3D) -> void:
	if actor.has_node("HealthComponent"):
		var actor_health_component: HealthComponent = actor.get_node("HealthComponent") as HealthComponent
		actor_health_component.take_damage(amount)
