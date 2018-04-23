extends Control

func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().change_scene("res://MainMenu.tscn")

func _on_ToMainMenuButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
