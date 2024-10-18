extends Node3D

@onready var timer_lbl: Label = %timer_lbl
@onready var maddie_timer: Timer = $MaddieTimer
@onready var door: RigidBody3D = $Door

@export var time: int = 60

var time_left: int = time
# tally
var maddie: int
var priest: int
var neutral: int


func _ready() -> void:
	timer_lbl.text = "Time Left: {T}s".format({"T": time_left})


func _on_maddie_timer_timeout() -> void:
	time_left = clamp(time_left - 1, 0, time)
	timer_lbl.text = "Time Left: {T}s".format({"T": time_left})
	
	if time_left > 0:
		return
	
	# pause timer
	maddie_timer.paused = true
	
	match door.item_given:
		0:
			neutral += 1
		1:
			priest += 1
		_:
			maddie += 1
	
	print("Starting wait time now")
	await get_tree().create_timer(10).timeout
	maddie_timer.paused = false
	# reset timer
	time_left = time
	print("Finished wait time")
