extends CharacterBody2D
class_name PersonagemBase

@export_category("Objetos")
@export var textura: Sprite2D = null
@export var anim: AnimationPlayer = null
@export var area_de_ataque: CollisionShape2D

@export_category("Variaveis")
@export var velocidade_de_movimento: float = 256.0
@export var ataque: int
@export var vida: int
@export var classe_atual: String = ""
@export var enemy_score: int

var atacando: bool = false
var animacao_de_ataque: String = "ac"
var esta_morto: bool = false
var hit: bool = false

func _ready() -> void:
	if anim != null:
		anim.play("RESET")
		anim.animation_finished.connect(fim_de_animacao)
		

func _process(_delta: float) -> void:
	if atacando == true or esta_morto == true or hit == true:
		return
		
	var direcao: Vector2 = Input.get_vector(
		"move_l", "move_r", "move_u", "move_d")
	
	velocity = direcao * velocidade_de_movimento
	move_and_slide()
	animar()
	

func animar() -> void:
	if hit:
		return
	if classe_atual == "TNT":
		var direcao_do_mouse: Vector2 = global_position.direction_to(get_global_mouse_position())
		if direcao_do_mouse.x > 0:
			textura.flip_h = false
		if direcao_do_mouse.x < 0:
			textura.flip_h = true
	else:
		if velocity.x > 0:
			textura.flip_h = false
			area_de_ataque.position.x = 60
		elif velocity.x < 0:
			textura.flip_h = true
			area_de_ataque.position.x = -60
			
		if abs(velocity.x) > abs(velocity.y) and abs(velocity.x) > 0:
			animacao_de_ataque = "ah"
			area_de_ataque.position.y = -32
		elif velocity.y > 0:
			animacao_de_ataque = "ab"
		elif velocity.y < 0:
			animacao_de_ataque = "ac"
	
	if Input.is_action_just_pressed("atacar"):
		atacando = true
		
	if anim != null:
		if atacando == true:
			if classe_atual == "TNT":
				animacao_de_ataque = "ataque"
			anim.play(animacao_de_ataque)
		elif velocity:
			anim.play("andando")
		else:
			anim.play("parado")


func instanciar_projetil() -> void:
	var projetil: ProjetilBase = load("res://personagens/scenes/dinamite.tscn").instantiate()
	projetil.direcao = global_position.direction_to(get_global_mouse_position())
	projetil.global_position = global_position + Vector2(0, -32)
	get_tree().root.add_child(projetil)


func fim_de_animacao(anim_nome: StringName) -> void:
	if (
		anim_nome == "ah" or
		anim_nome == "ab" or
		anim_nome == "ac" or
		anim_nome == "ataque" or
		anim_nome == "perdendo_vida"
	):
		atacando = false
		hit = false
	if not esta_morto:
		anim.play("parado")


func area_em_contato(area: Area2D) -> void:
	var alvo = area.get_parent()

	if alvo != self and alvo.has_method("causar_dano"):
		alvo.causar_dano(ataque)
	
	
func causar_dano(dano_sofrido: int) -> void:
	if esta_morto == true:
		return
	vida -= dano_sofrido
	hit = true
	if vida <= 0:
		anim.play("morte")
		await anim.animation_finished
		esta_morto = true
		GameManager.add_score(enemy_score)
		if classe_atual == "CAV" or classe_atual == "TNT" or classe_atual == "FIRE":
			chamar_game_over()
		else:
			queue_free()
		return
			
	anim.play("perdendo_vida")
	
	
func chamar_game_over():
	await get_tree().create_timer(1.5).timeout
	Transition.change_scene("res://personagens/scenes/game_over.tscn")
	
