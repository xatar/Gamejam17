extends SpringArm3D

@export var player: Player

func _process(delta: float) -> void:
	if not player:
		queue_free()
		return
		
	position = player.position + Vector3.UP * 2
