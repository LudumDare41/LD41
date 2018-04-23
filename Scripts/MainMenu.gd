extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


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
