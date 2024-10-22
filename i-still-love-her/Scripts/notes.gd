class_name Note
extends Interactable

@export_multiline var note: String

@onready var notes_label: RichTextLabel = $CanvasLayer/Notes/BG/NotesLabel
@onready var canvas_layer: CanvasLayer = $CanvasLayer


func _ready() -> void:
	interacted.connect(func(_x): canvas_layer.visible = true)
	notes_label.text = note
	canvas_layer.visible = false


func _input(_event: InputEvent) -> void:
	if !canvas_layer.visible:
		return
	
	if Input.is_action_just_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		canvas_layer.visible = false
