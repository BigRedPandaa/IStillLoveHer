class_name Interactable
extends CollisionObject3D


signal interacted(body)
@onready var playerInteractable = %Player


@export var prompt_message = "interact"

func interact(body):
		interacted.emit(body)
