extends Control


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	pass # replace with function body

func _on_ControlsButton_pressed():
	get_tree().change_scene("res://ControlsMenu.tscn")
	pass # replace with function body

func _on_ExitButton_pressed():
	get_tree().quit()
	pass # replace with function body

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://CreditsMenu.tscn")
	pass # replace with function body
