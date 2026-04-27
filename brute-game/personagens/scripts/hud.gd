extends CanvasLayer

@onready var score_label = $Control/Label

func _ready():
	GameManager.score_changed.connect(_on_score_updated)
	_on_score_updated(GameManager.current_score)

func _on_score_updated(new_value):
	score_label.text = "Score: " + str(new_value)
