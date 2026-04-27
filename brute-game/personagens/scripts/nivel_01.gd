extends Node2D

@onready var y_sort_node = $Ysort 
@onready var player_spawn_point: Marker2D = $Ysort/PlayerSpawnPoint

func _ready():
	if GameManager.selected_character_path:
		var player_scene = load(GameManager.selected_character_path)
		
		if player_scene:
			var player_instance = player_scene.instantiate()
			y_sort_node.add_child(player_instance)
			player_instance.global_position = player_spawn_point.global_position
		else:
			print("Erro: Não foi possível carregar a cena do personagem em: ", GameManager.selected_character_path)
