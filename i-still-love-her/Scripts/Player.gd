class_name Player
extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01

#What the Player is holding
@export_enum(
	"NOTHING", 
	"SYRINGE", 
	"FAMILYPHOTO",
	"MADDIESLAMB",
	"MADDIESHAMMER",
	"MADDIESKEY") var Holding: int = 0:
		set(x):
			Holding = x
			_change_display_hand(Holding)

#bobbing Var
const BOB_Freq = 2.5
const BOB_Amp = 0.07
var t_bob = 0.0


@onready var head = $Head
@onready var cam = $Head/Camera3D
@onready var hands: CanvasGroup = $Head/Camera3D/Hands
@onready var right_hand: Sprite2D = %RightHand


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
	hands.position = _handbob(t_bob)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_Freq) * BOB_Amp
	pos.x = cos(time * BOB_Freq/2) * BOB_Amp
	return pos

func _handbob(time: float) -> Vector2:
	var pos: Vector2 = Vector2.ZERO
	pos.x = (sin(time * BOB_Freq) * BOB_Amp) * 30
	pos.y = (cos(time * BOB_Freq/2) * BOB_Amp) * 20
	return pos


func _change_display_hand(hand_type: int) -> void:
	print(hand_type)
	match hand_type:
		0:
			#right_hand.texture = new_texture
			pass
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass
