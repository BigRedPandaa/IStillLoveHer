# CanvasGroupLock.gd
extends CanvasGroup

@export var camera: Camera3D
@export var offset: int = 250

func _process(_delta) -> void:
	var camera_rot: float = camera.rotation_degrees.x
	# Use a single formula that works for both positive and negative angles
	var final_offset: float = camera_rot * (1 + abs(offset) / 90.0)
	position.y = final_offset
