extends ProgressBar

@export var owning_character: CharacterBody2D

var health_component: HealthComponent

func _ready() -> void:
	health_component = owning_character.health_component
	set_percent(health_component.health, health_component.max_health)
	health_component.on_health_changed.connect(_on_health_changed)

func _on_health_changed(current_health: float, max_health: float) -> void:
	set_percent(current_health, max_health)

func set_percent(current_health: float, max_health: float) -> void:
	value = (current_health / max_health) * 100 if max_health > 0.0 else 0.0
