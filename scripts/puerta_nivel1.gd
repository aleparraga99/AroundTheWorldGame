extends Area2D

var playerNear = false
@onready var lbEnterDoorLevel1 = $lbEnterDoorLevel1
func _ready() -> void:
	lbEnterDoorLevel1.visible = false 
	connect("body_entered", Callable(self, "playerEntered"))
	connect("body_exited", Callable(self, "playerExited"))
 
func playerEntered(body):
	if body.name == "player":
		playerNear = true
		lbEnterDoorLevel1.visible = true
func playerExited(body):
	if body.name == "player":
		playerNear = false
		lbEnterDoorLevel1.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if playerNear and Input.is_action_just_pressed("entrar_a_puerta"):
		get_tree().change_scene_to_file("res://escenas/niveles/pantalla_nivel_1.tscn")
