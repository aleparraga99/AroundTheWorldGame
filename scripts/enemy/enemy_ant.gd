extends CharacterBody2D

const velocidadEnemigo1 = 500
const distanciaRecorrida = 200
var direction = 1
var posicionInicial : Vector2

var vida_maxima : int = 100
var vida_actual
var daño_recibido : int = 10

func die() -> void:
	queue_free()
		
func recibir_daño():
	vida_actual -= daño_recibido
	if vida_actual <= 0:
		die()
		
func _ready() -> void:
	posicionInicial = global_position
	vida_actual = vida_maxima
	
	
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
		
	if is_on_wall():
		direction *= -1
		$AnimatedSprite2D.flip_h = direction < 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataque_player"):
		recibir_daño()
		area.queue_free()
