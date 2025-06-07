extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_movimiento_del_player(delta)
	move_and_slide()

const velocidad = 300
const fuerza_de_salto = -600
const gravedad = 2000

func _movimiento_del_player(delta):
	var movimiento = Vector2.ZERO
	var screen_size = get_viewport_rect().size
	if Input.is_action_pressed("mover_derecha"):
		movimiento.x +=1
		
	if Input.is_action_pressed("mover_izquierda"):
		movimiento.x -=1
			
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	movimiento = movimiento.normalized() * velocidad
	velocity.y += gravedad * delta
	
	if is_on_floor():
		if Input.is_action_pressed("saltar"):
			velocity.y = fuerza_de_salto
	velocity.x = movimiento.x
