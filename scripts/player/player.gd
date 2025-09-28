extends CharacterBody2D

const VELOCIDAD = 300
const FUERZA_DE_SALTO = -800
const GRAVEDAD = 2500

var proyectil = preload("res://escenas/weaponBug.tscn")
var arrojando = false
var orientacion_derecha = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	pass
	


func _physics_process(delta: float) -> void:
	_movimiento_del_player(delta)
	move_and_slide()


func disparar():
	
	# Se instancia el proyectil	
	var nuevo_proyectil = proyectil.instantiate() 
	
	# Se inicializan las coordenadas (x;y) del proyectil
	var coordenada_inicial_x_proyectil = position.x + 25 
	var coordenada_inicial_y_proyectil = position.y - 30 
	
	# Se le asignan las coordenas inicializadas al proyectil
	var posicion_proyectil : Vector2 = Vector2(coordenada_inicial_x_proyectil, coordenada_inicial_y_proyectil)
	
	# Se crea un nuevo proyectil en la posición definida
	nuevo_proyectil.position = posicion_proyectil 
	
	# Defino la direccion del disparo dependiendo la orientación del player
	if orientacion_derecha:
		nuevo_proyectil.velocidad = Vector2(1000,-500)
	else:
		nuevo_proyectil.velocidad = Vector2(-1000,-500)
		
	# Se agrega la instancia del poyectil como nodo hijo de player	
	get_parent().add_child(nuevo_proyectil) 
	
	
func _movimiento_del_player(delta):
	
	var movimiento = Vector2.ZERO
	var screen_size = get_viewport_rect().size

	# Desplazamiento horizontal
	if Input.is_action_pressed("mover_derecha"):
		orientacion_derecha = true
		movimiento.x += 1
		animated_sprite_2d.flip_h = false
	
	elif Input.is_action_pressed("mover_izquierda"):
		orientacion_derecha = false
		movimiento.x -= 1
		animated_sprite_2d.flip_h = true


	if not animated_sprite_2d.is_playing() and (animated_sprite_2d.animation == "walk" or animated_sprite_2d.animation == "jump" or animated_sprite_2d.animation == "throw") and is_on_floor():
		animated_sprite_2d.play("idle")
		
	# Animaciones
	if Input.is_action_just_pressed("arrojar"):
		animated_sprite_2d.play("throw") 
		disparar()
		
	elif movimiento.x != 0 and is_on_floor():
		animated_sprite_2d.play("walk")
	elif movimiento.x == 0 and animated_sprite_2d.is_playing() and (animated_sprite_2d.animation == "walk"):
		animated_sprite_2d.stop()
	
	
	if Input.is_action_just_pressed("saltar") and is_on_floor():
			velocity.y = FUERZA_DE_SALTO
			animated_sprite_2d.play("jump")
		
	# Normalizar y aplicar velocidad horizontal
	movimiento = movimiento.normalized() * VELOCIDAD
	velocity.x = movimiento.x


	velocity.y += GRAVEDAD * delta
	
	
