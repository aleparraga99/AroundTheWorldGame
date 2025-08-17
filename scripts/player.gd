extends CharacterBody2D

const velocidad = 300
const fuerza_de_salto = -800
const gravedad = 2500

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	_movimiento_del_player(delta)
	_arrojar()
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

	else: $AnimatedSprite2D.stop()
			
	
			
	# Normalizar y aplicar velocidad horizontal
	movimiento = movimiento.normalized() * velocidad
	velocity.x = movimiento.x

	# --- Saltar ---
	if is_on_floor() and Input.is_action_just_pressed("saltar"):
		velocity.y = fuerza_de_salto
		$AnimatedSprite2D.play("jump")

	# --- Animaciones ---
	if is_on_floor():
		if movimiento.x != 0:
			$AnimatedSprite2D.play("walk")
		elif not is_on_floor() and movimiento.x == 0:
			$AnimatedSprite2D.play("jump") 
		else:
			$AnimatedSprite2D.stop()
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")   # subiendo
		else:
			$AnimatedSprite2D.play("fall")   # cayendo

	# --- Gravedad y límites de pantalla ---
	velocity.y += gravedad * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func _arrojar():
	if Input.is_action_just_pressed("arrojar"):
		$AnimatedSprite2D.play("throw")
