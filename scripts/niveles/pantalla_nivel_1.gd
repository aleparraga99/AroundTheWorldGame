extends Node2D
@onready var player = $player


func _ready() -> void:
	player.connect('muerto',morir)


func morir():
	var muerte = preload("res://escenas/screen_elements/muerto.tscn").instantiate()
	add_child(muerte)
	$AudioStreamPlayer.stop()
	
	
func _process(delta: float) -> void:
	pass

func _on_puerta_niveles_body_entered(body: Node2D) -> void:
	if body.is_in_group("cuerpo_player"):
		get_tree().change_scene_to_file("res://escenas/screen_elements/fin.tscn")
