extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(target_path: String):
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file(target_path)
	
	animation_player.play("fade_from_black")
	
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
