extends CharacterBody2D
class_name player

# Atributos
const VELOCIDAD = 300
const FUERZA_DE_SALTO = -800
const GRAVEDAD = 2500

var proyectil = preload("res://escenas/player/weaponBug.tscn")

var arrojando = false # Bandera
var orientacion_derecha = true # Bandera

var vida_max: int = 100
var vida_actual
var daño_recibido: int = 10

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func die():
	queue_free()
	get_tree().change_scene_to_file("res://escenas/screen_elements/fin.tscn")

func recibir_daño(): 
	vida_actual -= daño_recibido
	print(str(vida_actual))
	if vida_actual <= 0:
		die()

func _ready() -> void:
	vida_actual = vida_max
	



	
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
		

	movimiento = movimiento.normalized() * VELOCIDAD
	velocity.x = movimiento.x
	velocity.y += GRAVEDAD * delta
	
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataque_enemy"):
		recibir_daño()


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
