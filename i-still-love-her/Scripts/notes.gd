class_name Note
extends Interactable

@export_multiline var note: String

@onready var notes_label: RichTextLabel = $CanvasLayer/Notes/BG/NotesLabel
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var note_sound: AudioStreamPlayer3D = $NoteSound

func _ready() -> void:
	interacted.connect(func(_x):
		if !canvas_layer.visible:
			note_sound.play()
			show_note())
	notes_label.text = note
	canvas_layer.visible = false

func show_note() -> void:
	canvas_layer.visible = true
	# This will make the note capture all input events
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_process_input(true)
	# Optionally, you can set a higher process priority to ensure the note receives input first
	process_priority = 100

func hide_note() -> void:
	canvas_layer.visible = false
	# Restore the previous mouse mode (you might want to store the previous state)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(false)
	process_priority = 0

func _input(_event: InputEvent) -> void:
	if !canvas_layer.visible:
		return
	
	if Input.is_action_just_pressed(&"Interact"):
		hide_note()
		# Stop the event from propagating further
		get_viewport().set_input_as_handled()
