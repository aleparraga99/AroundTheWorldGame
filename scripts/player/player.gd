extends CharacterBody2D
class_name player




# Atributos
const VELOCIDAD = 300
const FUERZA_DE_SALTO = -800
const GRAVEDAD = 2500

var proyectil = preload("res://escenas/player/weaponBug.tscn")

var arrojando = false
var orientacion_derecha = true

signal muerto
var vida_actual: int = 100
var daño_recibido : int = 20


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func die():
	emit_signal("muerto")
	queue_free()
	
	
func recibir_daño():
	vida_actual -= daño_recibido
	if vida_actual <= 0:
		die()

	

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	_movimiento_del_player(delta)
	move_and_slide()
	

func disparar():
	var nuevo_proyectil = proyectil.instantiate() 
	var coordenada_inicial_x_proyectil = position.x + 25 
	var coordenada_inicial_y_proyectil = position.y - 30 
	var posicion_proyectil : Vector2 = Vector2(coordenada_inicial_x_proyectil, coordenada_inicial_y_proyectil)
	nuevo_proyectil.position = posicion_proyectil 
	
	if orientacion_derecha:
		nuevo_proyectil.velocidad = Vector2(1000,-500)
	else:
		nuevo_proyectil.velocidad = Vector2(-1000,-500)
		
	get_parent().add_child(nuevo_proyectil) 

func _movimiento_del_player(delta):
	var movimiento = Vector2.ZERO
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
