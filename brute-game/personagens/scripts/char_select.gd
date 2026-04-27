extends Control

@onready var character_slots: GridContainer = $GridContainer
@onready var select = $GridContainer/warrior_b
@onready var character_previews: Node2D = $Chars

func _ready() -> void:
	select.grab_focus()
	
	for preview in character_previews.get_children():
		preview.visible = false
	
	var nome_do_primeiro_sprite = String(select.name)
	var primeiro_preview = character_previews.get_node(nome_do_primeiro_sprite)
	
	if primeiro_preview:
		primeiro_preview.visible = true
	
	for button in character_slots.get_children():
		if button is TextureButton:
			button.set_meta("character_scene", "res://personagens/scenes/" + button.name + ".tscn")
			button.pressed.connect(Callable(self, "on_pressed_button").bind(button))
			button.focus_entered.connect(Callable(self, "on_button_focus_entered").bind(button))
			button.mouse_entered.connect(func(): button.grab_focus())


func on_button_focus_entered(button):
	for preview in character_previews.get_children():
		preview.visible = false
	
	var sprite_para_mostrar = character_previews.get_node(String(button.name))
	if sprite_para_mostrar:
		sprite_para_mostrar.visible = true
	
	
func on_pressed_button(button):
	if button.name.begins_with("?"):
		return
	var character_path = button.get_meta("character_scene")
	if character_path:
		GameManager.selected_character_path = character_path
		
		Transition.change_scene("res://personagens/scenes/niveis/nivel_01.tscn")
