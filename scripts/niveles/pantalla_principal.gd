extends Node2D
@onready var player = $player


func _ready() -> void:
	player.connect('muerto',morir)


func morir():
	var muerte = preload("res://escenas/screen_elements/muerto.tscn").instantiate()
	add_child(muerte)
	
	
func _process(delta: float) -> void:
	pass
