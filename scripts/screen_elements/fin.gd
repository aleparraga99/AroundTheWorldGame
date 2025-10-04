extends Node


func _ready() -> void:
	get_tree().paused = false
	$ColorRect.visible = false
	$Label.visible = false

func _process(delta):
	if Input.is_action_just_pressed("pausa"):
			get_tree().change_scene_to_file("res://escenas/niveles/pantalla_nivel_1.tscn")
