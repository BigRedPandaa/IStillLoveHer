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
var is_in_air: bool = false

var footstep_audio = AudioStreamPlayer
var jumping_audio = AudioStreamPlayer
var landing_audio = AudioStreamPlayer
var pickup_audio = AudioStreamPlayer
var give_audio = AudioStreamPlayer

@onready var head = $Head
@onready var cam = $Head/Camera3D
@onready var hands: CanvasGroup = $Head/Camera3D/Hands
@onready var right_hand: Sprite2D = %RightHand


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	footstep_audio = $FootstepAudio
	jumping_audio = $JumpingAudio
	landing_audio = $LandingAudio
	pickup_audio = $PickupAudio
	give_audio = $GiveAudio

func _unhandled_input(event: InputEvent) -> void:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * SENSITIVITY)
			cam.rotate_x(-event.relative.y * SENSITIVITY)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		is_in_air = true
	
	if is_on_floor() and is_in_air == true:
		play_sound_landing()
		is_in_air = false

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_sound_Jumping()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			play_sound_footstep()
		else:
			stop_sound_footstep()
	
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		stop_sound_footstep()
	
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

func play_sound_footstep():
	if not footstep_audio.playing:
		footstep_audio.play()
		

func stop_sound_footstep():
	if footstep_audio.playing:
		footstep_audio.stop()

func play_sound_Jumping():
	if not jumping_audio.playing:
		jumping_audio.play()

func play_sound_landing():
	if not landing_audio.playing:
		landing_audio.play()

func play_sound_pickup():
	if not pickup_audio.playing:
		pickup_audio.play()

func play_sound_give():
	if not give_audio.playing:
		give_audio.play()

func _change_display_hand(hand_type: int) -> void:
	print(hand_type)
	match hand_type:
		0:
			play_sound_give()
			#right_hand.texture = new_texture
			pass
		1:
			#right_hand.texture = 
			play_sound_pickup()
			pass
		2:
			play_sound_pickup()
			pass
		3:
			play_sound_pickup()
			pass
		4:
			play_sound_pickup()
			pass
		5:
			play_sound_pickup()
			pass
		6:
			play_sound_pickup()
			pass
