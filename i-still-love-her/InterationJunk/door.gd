class_name Door
extends Interactable

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

var item_given: int
var needle_count: int

const ISLH_JAOCOBIW = preload("res://Assets/Sounds/voice_lines/ISLH_Jaocobiw.mp3")
const MADDIEGIFT_1 = preload("res://Assets/Sounds/voice_lines/maddiegift_1.mp3")
const MADDIE_GIFT_2_REVISED = preload("res://Assets/Sounds/voice_lines/MaddieGift_2revised.mp3")
const MADDIE_GIFT_3 = preload("res://Assets/Sounds/voice_lines/MaddieGift_3.mp3")
const MADDIE_NEEDLE_1 = preload("res://Assets/Sounds/voice_lines/MaddieNeedle_1.mp3")
const MADDIE_NEEDLE_3 = preload("res://Assets/Sounds/voice_lines/MaddieNeedle_3.mp3")
const MADDIE_NEEDLE_4 = preload("res://Assets/Sounds/voice_lines/MaddieNeedle_4.mp3")
const MAIDDE_NEEDLE_2 = preload("res://Assets/Sounds/voice_lines/MaiddeNeedle_2.mp3")

signal item_recieved(item: int)


func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted(body: Player) -> void:
	# Door stores the item given to Maddie
	item_given = body.Holding
	
	match item_given:
		1:
			#Audio player plays a specific sound
			needle_count += 1
			match needle_count:
				1:
					audio_stream_player_3d.stream = MADDIE_NEEDLE_1
				2:
					audio_stream_player_3d.stream = MAIDDE_NEEDLE_2
				3:
					audio_stream_player_3d.stream = MADDIE_NEEDLE_3
				4:
					audio_stream_player_3d.stream = MADDIE_NEEDLE_4
		2:
			audio_stream_player_3d.stream = MADDIE_GIFT_2_REVISED
		3:
			audio_stream_player_3d.stream = MADDIE_GIFT_3
		4:
			audio_stream_player_3d.stream = MADDIE_GIFT_3
		5:
			audio_stream_player_3d.stream = MADDIEGIFT_1
	
	audio_stream_player_3d.play()
	
	print("player gave maddie: ", item_given)
	item_recieved.emit(item_given)
	# Remove the selected item, from the player
	body.Holding = 0
