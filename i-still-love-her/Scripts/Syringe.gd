extends Interactable


func _on_interacted(body: Variant) -> void:
	
	print("holding syringe")
	queue_free()
