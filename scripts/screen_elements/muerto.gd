extends CanvasLayer
class_name muerte


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.visible = true
	$Label.visible = true
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ok"):
		get_tree().change_scene_to_file("res://escenas/screen_elements/menu_de_inicio.tscn")
