extends CharacterBody2D

const velocidadEnemigo1 = 500
const distanciaRecorrida = 200
var direction = 1
var posicionInicial : Vector2

func _ready() -> void:
	posicionInicial = global_position
	
func _physics_process(delta: float) -> void:
	velocity.x = direction * velocidadEnemigo1
	move_and_slide()
	
	var distanciaDesdeInicio = global_position.x - posicionInicial.x
	
	if distanciaDesdeInicio > distanciaRecorrida:
		direction = -1
		$Sprite2D.scale.x = 1
	elif distanciaDesdeInicio <- distanciaRecorrida:
		direction = 1
		$Sprite2D.scale.x = -1
		
func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
