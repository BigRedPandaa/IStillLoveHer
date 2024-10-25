extends Interactable

const ISLH_LEAVE = preload("res://Assets/Videos/ISLH_Leave.ogv")

func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted(_body: Player) -> void:
	get_tree().get_nodes_in_group("CutsceneManager")[0].play_cutscene(ISLH_LEAVE)
