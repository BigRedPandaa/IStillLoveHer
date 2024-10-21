extends PanelContainer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/setting's_menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
