extends MarginContainer


func _ready() -> void:
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		if visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = !visible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_quit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_to_desktop_pressed() -> void:
	get_tree().quit()
