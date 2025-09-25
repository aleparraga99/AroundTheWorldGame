extends Area2D

var playerNear = false

@onready var lbEnterDoorTutorial = $lbEnterDoorTutorial
func _ready() -> void:
	lbEnterDoorTutorial.visible = false
	connect("body_entered", Callable(self, "playerEntered"))
	connect("body_exited", Callable(self, "playerExited"))
 
func playerEntered(body):
	if body.name == "player":
		playerNear = true
		lbEnterDoorTutorial.visible = true

func playerExited(body):
	if body.name == "player":
		playerNear = false
		lbEnterDoorTutorial.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if playerNear and Input.is_action_just_pressed("entrar_a_puerta"):
		get_tree().change_scene_to_file("res://escenas/niveles/Tutorial.tscn")
