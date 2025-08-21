extends CharacterBody2D

const velocidadEnemigo1 = 500
const distanciaRecorrida = 200
var direction = 1
var posicionInicial : Vector2

func _ready() -> void:
	posicionInicial = global_position
	
func _physics_process(delta: float) -> void:
	velocity.x = direction * velocidadEnemigo1
	$AnimatedSprite2D.play("walk")
	move_and_slide()
	
	var distanciaDesdeInicio = global_position.x - posicionInicial.x
	
	if distanciaDesdeInicio > distanciaRecorrida:
		direction = -1
		$AnimatedSprite2D.flip_h = true
	elif distanciaDesdeInicio <- distanciaRecorrida:
		direction = 1
		$AnimatedSprite2D.flip_h = false
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	queue_free()
