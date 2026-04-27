extends PersonagemBase
class_name BonecoDeTreino

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

@export var recarga_do_ataque: Timer

var unidade_no_alcance = null
var player_ref: CharacterBody2D = null

func _ready() -> void:
	super()
	anim.play("parado")


func _process(_delta: float) -> void:
	if esta_morto == true:
		return
	if unidade_no_alcance == null:
		return
		
	if atacando == true or esta_morto == true or hit == true:
		return
	
	nav_agent.target_position = unidade_no_alcance.global_position
	var distancia = global_position.distance_to(unidade_no_alcance.global_position)
	var proximo_ponto = nav_agent.get_next_path_position()
	var direcao = global_position.direction_to(proximo_ponto)
	
	if direcao.x > 0:
		area_de_ataque.position.x = 32
		textura.flip_h = false
	if direcao.x < 0:
		area_de_ataque.position.x = -32
		textura.flip_h = true
		
	if distancia <= 70.0 and not atacando and vida > 0:
		anim.play("ataque_martelo")
		recarga_do_ataque.start()
		atacando = true
		
	if (player_ref == null or player_ref.esta_morto) and distancia >= 70.0:
		velocity = Vector2.ZERO
		anim.play("andando")
		
	velocity = direcao * velocidade_de_movimento
	move_and_slide()


func deteccao_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		return
	if body == self or body.classe_atual == "ENE" or body.classe_atual == "BOSS":
		return
		
	unidade_no_alcance = body


func deteccao_body_exited(body: Node2D) -> void:
	anim.play("parado")
	if body is TileMapLayer:
		return
	if body == self or body.classe_atual == "ENE" or body.classe_atual == "BOSS":
		return
		
	unidade_no_alcance = null


func quando_ataque_recarregar() -> void:
	atacando = false
