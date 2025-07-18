class_name AttackComponent
extends Node

func deal_damage(amount: float, actor: CharacterBody2D) -> void:
	if actor.has_node("HealthComponent"):
		actor.health_component.take_damage(amount)
