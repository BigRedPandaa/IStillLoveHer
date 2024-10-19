extends Interactable


func _on_interacted(body: Player) -> void:
	body.Holding = 2
	print("holding book 1")
	queue_free()
