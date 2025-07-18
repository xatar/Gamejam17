class_name HealthComponent
extends Node

signal on_health_changed(current_health: float, max_health: float)
signal on_death

@export var max_health: float = 50.0

var health: float

func _ready() -> void:
	health = max_health

func take_damage(amount: float) -> void:
	health = clamp(health - amount, 0.0, max_health)
	emit_signal("on_health_changed", health, max_health)
	
	if (health <= 0.0):
		emit_signal("on_death")

func heal(amount: float) -> void:
	health = clamp(health + amount, 0.0, max_health)
	emit_signal("on_health_changed", health, max_health)
