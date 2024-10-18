class_name CutsceneManager
extends CanvasLayer

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer

signal finished


func _ready() -> void:
	visible = false
	video_stream_player.finished.connect(func(): 
		finished.emit()
		get_tree().paused = false
		visible = false)


func play_cutscene(cutscene: String) -> void:
	visible = true
	var stream: VideoStreamTheora = load(cutscene)
	video_stream_player.stream = stream
	video_stream_player.play()
	get_tree().paused = true
