extends Node2D

@export var y_sort_node: Node2D
@export var troll_scene: PackedScene = preload("res://personagens/scenes/enemys/troll.tscn")

@export var enemy_data: Dictionary = {
	preload("res://personagens/scenes/enemys/skull.tscn"): [100, 0],
	preload("res://personagens/scenes/boneco_de_treino.tscn"): [80, 0]
}

var time_elapsed: float = 0.0
var troll_interval: float = 120.0
var next_troll_spawn_time: float = 120.0

@onready var spawn_timer = $SpawnTimer
@onready var path_follow = $Path2D/PathFollow2D

func _process(delta: float) -> void:
	time_elapsed += delta
	
	if time_elapsed >= next_troll_spawn_time:
		spawn_forced_enemy(troll_scene)
		next_troll_spawn_time += troll_interval

func spawn_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	
	if player and not player.esta_morto:
		spawn_enemy()
	else:
		spawn_timer.stop()


func spawn_enemy():
	if y_sort_node == null:
		y_sort_node = get_tree().get_first_node_in_group("sort_layer")
		if y_sort_node == null: return
	
	var available_enemies = []
	var total_weight = 0
	
	for enemy_scene in enemy_data.keys():
		var config = enemy_data[enemy_scene]
		if time_elapsed >= config[1]:
			available_enemies.append({"scene": enemy_scene, "weight": config[0]})
			total_weight += config[0]
			
	if available_enemies.is_empty():
		return
		
	#Sorteio ponderado
	var roll = randi() % total_weight
	var current_sum = 0
	var selected_scene: PackedScene = null
	
	for enemy in available_enemies:
		current_sum += enemy.weight
		if roll < current_sum:
			selected_scene = enemy.scene
			break
			
	if selected_scene:
		var pos = find_valid_spawn_position()
		if pos != Vector2.ZERO:
			_instantiate_enemy(selected_scene, pos)

func spawn_forced_enemy(specific_scene: PackedScene):
	if y_sort_node == null:
		y_sort_node = get_tree().get_first_node_in_group("sort_layer")
		
	var pos = find_valid_spawn_position()
	if pos != Vector2.ZERO and specific_scene:
		_instantiate_enemy(specific_scene, pos)


func find_valid_spawn_position() -> Vector2:
	var camadas_terreno = get_tree().get_nodes_in_group("chao")
	var max_tentativas = 15
	
	for i in range(max_tentativas):
		path_follow.progress_ratio = randf()
		var candidate_pos = path_follow.global_position
		
		var encontrou_agua = false
		var encontrou_chao = false
		
		for camada in camadas_terreno:
			if camada is TileMapLayer:
				var map_pos = camada.local_to_map(camada.to_local(candidate_pos))
				var tile_data = camada.get_cell_tile_data(map_pos)
				
				if tile_data:
					encontrou_chao = true
					var tileset = camada.tile_set
					if tileset.get_custom_data_layer_by_name("is_water") != -1:
						if tile_data.get_custom_data("is_water"):
							encontrou_agua = true
							break
		
		if encontrou_chao and not encontrou_agua:
			return candidate_pos
			
	return Vector2.ZERO

func _instantiate_enemy(scene: PackedScene, pos: Vector2):
	var enemy_instance = scene.instantiate()
	y_sort_node.add_child(enemy_instance)
	enemy_instance.global_position = pos
