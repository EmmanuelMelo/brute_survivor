extends Node2D
class_name Terreno

func _ready() -> void:
	var celulas_pontes: Array = $CamadaPontes.get_used_cells()
	var celulas_agua: Array = $CamadaAgua.get_used_cells()
	for celula in celulas_pontes:
		if celulas_agua.has(celula):
			$CamadaAgua.set_cell(celula, 0, Vector2i(0, 0), 1)
