class_name Door
extends Interactable

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

var item_given: int

func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted(body: Player) -> void:
	# Door stores the item given to Maddie
	item_given = body.Holding
	
	match item_given:
		1:
			#Audio player plays a specific sound
			pass
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass
	
	# Remove the selected item, from the player
	body.Holding = 0
	print("player gave maddie: ", )
	
	print("you are destitute")
