extends PersonagemBase
class_name Boss

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

@export var recarga_do_ataque: Timer
@export var tempo_exaustao: Timer
@export var shape: CollisionShape2D

var unidade_no_alcance = null
var player_ref: CharacterBody2D = null
var stamina: int = 0
var esta_exausto: bool = false


func _process(_delta: float) -> void:
	if esta_morto == true:
		return
	if unidade_no_alcance == null:
		return
		
	if atacando == true or esta_morto == true or hit == true or esta_exausto == true:
		return
	
	nav_agent.target_position = unidade_no_alcance.global_position
	var distancia = global_position.distance_to(unidade_no_alcance.global_position)
	
	if (stamina == 2 or stamina == 5) and not esta_exausto:
		anim.play("exausto")
		esta_exausto = true
		tempo_exaustao.start(3)
		return
	if stamina == 8 and not esta_exausto:
		anim.play("exausto")
		esta_exausto = true
		tempo_exaustao.start(6)
		return
		
	var proximo_ponto = nav_agent.get_next_path_position()
	var direcao = global_position.direction_to(proximo_ponto)
		
	if direcao.x > 0:
		area_de_ataque.position.x = 32
		shape.position.x = -53
		textura.flip_h = false
	if direcao.x < 0:
		area_de_ataque.position.x = -32
		shape.position.x = 53
		textura.flip_h = true
		
	if distancia <= 150.0 and not atacando and vida > 0:
		anim.play("atacando")
		recarga_do_ataque.start()
		atacando = true
		stamina += 1
		
	if (player_ref == null or player_ref.esta_morto) and distancia >= 151.0:
		velocity = Vector2.ZERO
		anim.play("andando")
		
	velocity = direcao * velocidade_de_movimento
	move_and_slide()


func deteccao_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		return
	if body == self or body.classe_atual == "ENE":
		return
		
	unidade_no_alcance = body


func deteccao_body_exited(body: Node2D) -> void:
	if esta_morto == true:
		return
	anim.play("parado")
	if body is TileMapLayer:
		return
	if body == self or body.classe_atual == "ENE":
		return
		
	unidade_no_alcance = null


func quando_ataque_recarregar() -> void:
	atacando = false


func exausto_timeout() -> void:
	esta_exausto = false
	if stamina == 2:
		stamina = 3
	if stamina == 5:
		stamina = 6
	if stamina == 8:
		stamina = 0


func causar_dano(dano_sofrido: int) -> void:
	if esta_exausto:
		super.causar_dano(dano_sofrido)


func fim_de_animacao(anim_nome: StringName) -> void:
	if anim_nome == "perdendo_vida" and esta_exausto and not esta_morto:
		hit = false
		anim.play("exausto")
		return
	super.fim_de_animacao(anim_nome)
