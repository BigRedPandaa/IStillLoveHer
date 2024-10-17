extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01

@export var Holding := HeldItem.NOTHING
#What the Player is holding
enum HeldItem {
	NOTHING,
	SYRINGE,
	FAMILYPHOTO,
	MADDIESLAMB,
	MADDIESHAMMER,
	MADDIESKEY,
}

#bobbing Var
const BOB_Freq = 2.5
const BOB_Amp = 0.07
var t_bob = 0.0


@onready var head = $Head
@onready var cam = $Head/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event: InputEvent) -> void:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * SENSITIVITY)
			cam.rotate_x(-event.relative.y * SENSITIVITY)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	#head-bobbing
	t_bob += delta * velocity.length() * float(is_on_floor())
	cam.transform.origin = _headbob(t_bob)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_Freq) * BOB_Amp
	pos.x = cos(time * BOB_Freq/2) * BOB_Amp
	return pos
	

func get_helditem(HeldItem):
	return Holding

func set_heldItem(NewItem):
	NewItem = HeldItem
	return HeldItem
