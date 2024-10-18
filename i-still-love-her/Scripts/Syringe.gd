extends Interactable


func _on_interacted(body: Player) -> void:
	body.Holding = 1
	print("holding syringe")
	queue_free()
