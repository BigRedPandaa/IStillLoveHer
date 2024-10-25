extends Interactable


func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted(body: Player) -> void:
	body.Holding = 3
	print("holding book 2")
	queue_free()
