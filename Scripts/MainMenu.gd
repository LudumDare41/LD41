extends Control


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event.is_action_pressed("quit") and not event.is_echo():
		get_tree().quit()

func _on_PlayButton_pressed():
	Game.musicMenu.stop()
	get_tree().change_scene("res://Main.tscn")

func _on_ControlsButton_pressed():
	get_tree().change_scene("res://ControlsMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://CreditsMenu.tscn")
