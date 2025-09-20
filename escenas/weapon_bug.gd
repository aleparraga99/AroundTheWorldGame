extends Node2D

@export var GRAVEDAD = 2500
const FUERZA_DE_DISPARO = 2500
const VELOCIDAD_INICIAL : Vector2 = Vector2(1000,-500)
var velocidad : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocidad = VELOCIDAD_INICIAL
	
	
func _physics_process(delta):
	velocidad.y += GRAVEDAD * delta
	position += velocidad * delta
	$AnimatedSprite2D.play("giro") # Ver si se puede mejorar el llamado a la animacion

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
