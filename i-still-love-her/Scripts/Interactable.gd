extends CollisionObject3D
class_name Interactable

signal interacted(body)
@onready var playerInteractable = %Player


@export var prompt_message = "interact"

func interact(body):
		interacted.emit(body)
