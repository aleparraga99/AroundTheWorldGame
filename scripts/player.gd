extends CharacterBody2D
const VELOCIDAD = 300
const FUERZA_DE_SALTO = -800
const GRAVEDAD = 2500
var proyectil = preload("res://escenas/weaponBug.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	_movimiento_del_player(delta)
	move_and_slide()

func disparar():
	var nuevo_proyectil = proyectil.instantiate() 
	
	var coordenada_inicial_x_proyectil = position.x
	var coordenada_inicial_y_proyectil = position.y - 30
	var posicion_proyectil : Vector2 = Vector2(coordenada_inicial_x_proyectil, coordenada_inicial_y_proyectil)
	nuevo_proyectil.position = posicion_proyectil
	
	get_parent().add_child(nuevo_proyectil)
	
	
	
	
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
		disparar()
		 
	elif movimiento.x != 0 and  is_on_floor():
		$AnimatedSprite2D.play("walk")
	elif is_on_floor():
		$AnimatedSprite2D.play("idle")

	if Input.is_action_just_pressed("saltar"):
		if is_on_floor():
			velocity.y = FUERZA_DE_SALTO
			animated_sprite_2d.play("jump")
		
	# Normalizar y aplicar velocidad horizontal
	movimiento = movimiento.normalized() * VELOCIDAD
	velocity.x = movimiento.x

	# Gravedad y límites de pantalla
	velocity.y += GRAVEDAD * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
