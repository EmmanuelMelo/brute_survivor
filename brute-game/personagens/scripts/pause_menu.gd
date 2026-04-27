extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	hide_menu()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not visible:
			show_menu()
		else:
			hide_menu()

func show_menu():
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$CenterContainer/VBoxContainer/Resume.grab_focus()

func hide_menu():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 

func resume_button_pressed():
	hide_menu()

func char_select_button_pressed():
	GameManager.current_score = 0
	Transition.change_scene("res://personagens/scenes/char_select.tscn")

func quit_button_pressed():
	Transition.change_scene("res://personagens/scenes/game_over.tscn")
