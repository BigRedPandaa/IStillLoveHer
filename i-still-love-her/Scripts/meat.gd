extends Interactable


func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted(body: Player) -> void:
	body.Holding = 4
	print("holding meat")
	queue_free()
