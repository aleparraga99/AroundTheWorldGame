extends CanvasLayer

func _ready() -> void:
	get_tree().paused = false
	$ColorRect.visible = false
	$Label.visible = false

func _process(delta):
	if Input.is_action_just_pressed("pausa"):
		get_tree().paused = not get_tree().paused
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
