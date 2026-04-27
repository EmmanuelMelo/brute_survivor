extends Node

signal score_changed(new_score)

var current_score: int = 0:
	set(value):
		current_score = value
		score_changed.emit(current_score)

var selected_character_path: String

func add_score(amount: int):
	current_score += amount
