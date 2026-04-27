extends Control

@onready var score_label = $CenterContainer2/VBoxContainer/ScoreLabel

func _ready():
	score_label.text = "Score: " + str(GameManager.current_score)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	send_score_to_web(GameManager.current_score)

func _on_restart_button_pressed():
	GameManager.current_score = 0
	Transition.change_scene("res://personagens/scenes/char_select.tscn")

func _on_quit_button_pressed():
	if OS.has_feature("web"):
		var js_code = """
			if (window.parent && window.parent.redirectToRanking) {
				window.parent.redirectToRanking();
			} else if (window.redirectToRanking) {
				window.redirectToRanking();
			}
		"""
		JavaScriptBridge.eval(js_code)
	else:
		get_tree().quit()

func send_score_to_web(val: int):
	if OS.has_feature("web"):
		var js_score = """
			console.log('Godot tentando enviar score: ' + {score});
			if (window.parent && window.parent.receiveScoreFromGodot) {
				window.parent.receiveScoreFromGodot({score});
			} else {
				console.error('React não encontrou a função receiveScoreFromGodot no parent!');
			}
		""".format({"score": str(val)})
		JavaScriptBridge.eval(js_score)
