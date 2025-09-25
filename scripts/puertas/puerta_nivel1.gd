extends Area2D

var playerNear = false
@onready var label_enter_door_level_1 = $label_enter_door_level_1
func _ready() -> void:
	label_enter_door_level_1.visible = false 
	connect("body_entered", Callable(self, "playerEntered"))
	connect("body_exited", Callable(self, "playerExited"))
 
func playerEntered(body):
	if body.name == "player":
		playerNear = true
		label_enter_door_level_1.visible = true
func playerExited(body):
	if body.name == "player":
		playerNear = false
		label_enter_door_level_1.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if playerNear and Input.is_action_just_pressed("entrar_a_puerta"):
		get_tree().change_scene_to_file("res://escenas/niveles/pantalla_nivel_1.tscn")
