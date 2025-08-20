extends CharacterBody2D

const VELOCIDAD = 300
const FUERZA_DE_SALTO = -800
const GRAVEDAD = 2500

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	_movimiento_del_player(delta)
	move_and_slide()
	
func _movimiento_del_player(delta):
	var movimiento = Vector2.ZERO
	var screen_size = get_viewport_rect().size

	# Desplazamiento horizontal
	
	if Input.is_action_pressed("mover_derecha"):
		movimiento.x += 1
		$AnimatedSprite2D.flip_h = false
	
	elif Input.is_action_pressed("mover_izquierda"):
		movimiento.x -= 1
		$AnimatedSprite2D.flip_h = true

	# Animaciones
	if Input.is_action_just_pressed("arrojar"):
		$AnimatedSprite2D.play("throw")  
	elif movimiento.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	if Input.is_action_just_pressed("saltar"):
		if is_on_floor():
			velocity.y = FUERZA_DE_SALTO
			$AnimatedSprite2D.play("jump")
		
			
		
	# Normalizar y aplicar velocidad horizontal
	movimiento = movimiento.normalized() * VELOCIDAD
	velocity.x = movimiento.x

	# Gravedad y límites de pantalla
	velocity.y += GRAVEDAD * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
