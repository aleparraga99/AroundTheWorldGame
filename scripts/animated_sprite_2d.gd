extends AnimatedSprite2D

var base_position: Vector2
var jump_offsets = [
	Vector2(0, 0),
	Vector2(0, -10),
	Vector2(0, -20),
	Vector2(0, -30),
	Vector2(0, -40),
	Vector2(0, -50),
] 


func _ready() -> void:
	base_position = position
	frame_changed.connect(_on_frame_changed)

func _on_frame_changed() -> void:
	if animation == "jump":
		if frame < jump_offsets.size():
			position = base_position + jump_offsets[frame]
