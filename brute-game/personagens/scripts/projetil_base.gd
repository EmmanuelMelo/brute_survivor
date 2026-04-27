extends Area2D
class_name ProjetilBase

var direcao: Vector2

@export var velocidade_de_movimento: float = 96.0
@export var velocidade_de_rotacao: float = 96.0
@export var textura: Sprite2D
@export var tempo_para_explosao: Timer
@export var formato_de_colisao: CollisionShape2D
@export var tempo_para_deletar: Timer
@export var quantidade_de_explosoes:int = 3
@export var ataque: int

func _ready() -> void:
	if direcao.x > 0:
		textura.flip_h = false
	if direcao.x < 0:
		textura.flip_h = true
		
		tempo_para_explosao.start(1.5)

func _process(delta: float) -> void:
	if tempo_para_deletar.is_stopped() == false:
		return
		
	position += (direcao * velocidade_de_movimento * delta)
	rotation_degrees += (direcao.x * delta * velocidade_de_rotacao)
	
	if Input.is_action_pressed("ativar_explosivo"):
		explosao()


func explosao() -> void:
	var efeito_da_explosao: Sprite2D = load("res://personagens/scenes/effects/explosao.tscn").instantiate()
	efeito_da_explosao.global_position = global_position
	get_tree().root.add_child(efeito_da_explosao)
	
	textura.hide()
	tempo_para_deletar.start(0.2)
	formato_de_colisao.set_deferred("disabled", false)


func quando_um_corpo_entrar_contato(body: Node2D) -> void:
	if body is PersonagemBase:
		body.causar_dano(ataque)


func deletar() -> void:
	queue_free()


func quando_area_entrar_em_contato(area: Area2D) -> void:
	var alvo = area.get_parent()
	if alvo != self and alvo.has_method("causar_dano"):
		alvo.causar_dano(ataque)
