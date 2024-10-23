# CanvasGroupLock.gd
extends CanvasGroup

# Reference to the 3D camera
@export var camera: Camera3D

# To store the locked rotation
var locked_rotation = Vector3.ZERO

func _ready():
	# Store the initial vertical rotation
	locked_rotation.x = camera.rotation_degrees.x

func _process(delta):
	# Get the current camera rotation
	var camera_rotation = camera.rotation_degrees
	# Lock the vertical (X-axis) rotation
	camera_rotation.x = locked_rotation.x
	
	# Apply the locked rotation to the CanvasGroup
	for child in get_children():
		if child is CanvasGroup:
			child.rotation_degrees = camera_rotation
