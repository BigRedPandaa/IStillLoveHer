extends Interactable


func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted(body: Player) -> void:
	body.Holding = 1
	print("holding syringe")
	queue_free()
