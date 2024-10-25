class_name Interactable
extends CollisionObject3D

signal interacted(body)

@export var prompt_message = "interact"


func interact(body):
		interacted.emit(body)
