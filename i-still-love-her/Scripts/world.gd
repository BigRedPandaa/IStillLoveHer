extends Node3D

@onready var syringe_spawn_pos: Marker3D = $Items/SyringeSpawnPos
@onready var book: RigidBody3D = $Items/Book
@onready var book_2: RigidBody3D = $Items/Book2
@onready var meat: RigidBody3D = $Items/Meat
@onready var key: RigidBody3D = $Items/Key
@onready var cutscene_manager: CutsceneManager = %CutsceneManager

# tally
var maddie: int
var priest: int
var intro_played: bool = false

const BOOK_2 = preload("res://ImportedObjects/book2.tscn")
const BOOK = preload("res://ImportedObjects/book.tscn")
const CANDLE = preload("res://ImportedObjects/Candle.tscn")
const KEY = preload("res://ImportedObjects/Key.tscn")
const MEAT = preload("res://ImportedObjects/Meat.tscn")
const SYRINGE = preload("res://ImportedObjects/syringe.tscn")

# Videos
const ISLH_INTRO_CUT = preload("res://Assets/Videos/ISLH_IntroCut.ogv")
const ISLH_EATEN = preload("res://Assets/Videos/ISLH_Eaten.ogv")
const ISLH_PRIEST = preload("res://Assets/Videos/ISLH_Priest.ogv")


func _ready() -> void:
	_spawn_syringe()
	cutscene_manager.play_cutscene(ISLH_INTRO_CUT)


func _spawn_syringe() -> void:
	var syringe: Interactable = SYRINGE.instantiate()
	get_tree().get_root().add_child(syringe)
	syringe.global_position = syringe_spawn_pos.global_position


func _on_door_item_recieved(item: int) -> void:
	print("From World: ", item)
	match item:
		0:
			pass
		1:
			priest += 1
			_spawn_syringe()
		_:
			maddie += 1
	
	print("maddie: ", maddie)
	print("priest: ", priest)
	
	if maddie == 5:
		cutscene_manager.play_cutscene(ISLH_EATEN)
	if priest == 5:
		cutscene_manager.play_cutscene(ISLH_PRIEST)


func _on_candle_interacted(_body: Variant) -> void:
	book.visible = true


func _on_book_interacted(_body: Variant) -> void:
	meat.visible = true


func _on_meat_interacted(_body: Variant) -> void:
	book_2.visible = true


func _on_book_2_interacted(_body: Variant) -> void:
	key.visible = true


func _on_cutscene_manager_finished() -> void:
	if intro_played:
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	else:
		intro_played = true
