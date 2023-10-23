extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Start_Screen.tscn")


func _on_button_2_pressed():
	get_tree().quit()


func _on_check_box_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


#func _on_check_box_button_down():
#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
#
#
#
#
#func _on_check_box_button_up():
#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
