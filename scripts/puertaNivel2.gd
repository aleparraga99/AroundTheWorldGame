extends Area2D

var playerNear = false

func _ready() -> void:
	connect("body_entered", Callable(self, "playerEntered"))
	connect("body_exited", Callable(self, "playerExited"))
 
func playerEntered(body):
	if body.name == "player":
		playerNear = true

func playerExited(body):
	if body.name == "player":
		playerNear = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if playerNear and Input.is_action_just_pressed("entrar_a_puerta"):
		get_tree().change_scene_to_file("res://pantalla_nivel_2.tscn")
