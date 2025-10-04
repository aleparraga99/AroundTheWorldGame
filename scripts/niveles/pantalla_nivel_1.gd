extends Node2D

@onready var player = $player
@onready var death_screen = $fin
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.muerto.connect(_on_player_muerto)

func _on_player_muerto():
	death_screen.visible = true
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
